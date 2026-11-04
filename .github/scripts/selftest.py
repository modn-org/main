"""Check that validate.py rejects broken copies of the bucket."""
import argparse
import json
from pathlib import Path
import shutil
import tempfile

from pack import BUCKET_ENTRIES
from validate import ValidationError, validate


def manifests(bucket: Path) -> list[Path]:
    return sorted(
        path for path in (bucket / "games").glob("*/*.json")
        if path.name != "module.json" and "@" not in path.stem
    )


def edit(path: Path, change) -> None:
    document = json.loads(path.read_text(encoding="utf-8"))
    change(document)
    path.write_text(json.dumps(document), encoding="utf-8")


def future_host_api(bucket: Path) -> None:
    module = sorted((bucket / "games").glob("*/module.json"))[0]
    edit(module, lambda m: m.update(api_version=m["api_version"] + 1))


def unavailable_dependency(bucket: Path) -> None:
    edit(manifests(bucket)[0],
         lambda m: m.update(dependencies=[*m.get("dependencies", []), "validation-missing"]))


def unsatisfied_requirement(bucket: Path) -> None:
    constrained = next(p for p in manifests(bucket)
                       if json.loads(p.read_text(encoding="utf-8")).get("dependency_versions"))
    edit(constrained, lambda m: m["dependency_versions"].update(
        {next(iter(m["dependency_versions"])): ">=999999"}))


CASES = {
    "future host API": (future_host_api, "incompatible host API"),
    "unavailable dependency": (unavailable_dependency, "validation-missing"),
    "unsatisfied version requirement": (unsatisfied_requirement, ">=999999"),
}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("bucket", type=Path)
    parser.add_argument("modn", type=Path)
    args = parser.parse_args()
    for name, (mutate, expected) in CASES.items():
        with tempfile.TemporaryDirectory() as work:
            copy = Path(work) / "bucket"
            for entry in BUCKET_ENTRIES:
                source = args.bucket / entry
                if source.is_dir():
                    shutil.copytree(source, copy / entry)
                else:
                    copy.mkdir(exist_ok=True)
                    shutil.copy2(source, copy / entry)
            mutate(copy)
            try:
                validate(copy, args.modn, Path(work) / "dist")
            except ValidationError as error:
                if expected not in str(error):
                    raise SystemExit(f"{name}: wrong rejection: {error}") from None
                print(f"ok: {name} rejected")
                continue
            raise SystemExit(f"{name}: validate.py accepted a broken bucket")
    print(f"Self-test rejected {len(CASES)} broken buckets.")


if __name__ == "__main__":
    main()
