"""Validate the main bucket with a modn binary and write its release ZIP."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import tempfile

from pack import pack


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(f"bucket validation failed: {message}")


def current_releases(bucket: Path) -> set[tuple[str, str]]:
    return {
        (path.parent.name, path.stem)
        for path in (bucket / "games").glob("*/*.json")
        if path.name != "module.json" and "@" not in path.stem
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("bucket", type=Path)
    parser.add_argument("modn", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    archive = args.output.resolve() / "main-bucket.zip"
    pack(args.bucket, archive)
    with tempfile.TemporaryDirectory() as work:
        repeat = Path(work) / "repeat.zip"
        pack(args.bucket, repeat)
        require(repeat.read_bytes() == archive.read_bytes(), "packing is not deterministic")
        env = {key: value for key, value in os.environ.items() if not key.startswith("MODN_")}
        env["LOCALAPPDATA"] = str(Path(work) / "data")
        env["MODN_MAIN_BUCKET_SOURCE"] = str(archive)

        def modn(*command: str):
            result = subprocess.run(
                [str(args.modn.resolve()), "--json", *command],
                env=env, capture_output=True, text=True, check=False)
            require(result.returncode == 0, f"modn {' '.join(command)}: {result.stderr.strip()}")
            return json.loads(result.stdout)

        require(modn("bucket", "update")["changed"], "first update reported no change")
        require(not modn("bucket", "update")["changed"], "repeated update reported a change")
        listed = {(p["game"], p["id"]) for p in modn("search") if p["bucket"] == "main"}
        expected = current_releases(args.bucket)
        require(listed == expected, f"search differs from manifests: {sorted(listed ^ expected)}")
        games = sorted({game for game, _ in expected})
        print(f"Validated {len(expected)} packages for {len(games)} games: {', '.join(games)}")


if __name__ == "__main__":
    main()
