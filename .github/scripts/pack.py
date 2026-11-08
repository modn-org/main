"""Build the release bucket ZIP with reproducible paths, metadata and bytes."""
import argparse
from pathlib import Path
import zipfile

BUCKET_ENTRIES = ("PROVENANCE.md", "bucket.json", "games")


def bucket_files(source: Path) -> list[Path]:
    files = []
    for name in BUCKET_ENTRIES:
        top = source / name
        for path in [top, *top.rglob("*")] if top.is_dir() else [top]:
            if path.is_symlink():
                raise ValueError(f"Linked bucket entry: {path}")
            if path.is_file():
                files.append(path)
    return sorted(files, key=lambda p: p.relative_to(source).as_posix())


def pack(source: Path, output: Path) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(output, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for path in bucket_files(source):
            entry = zipfile.ZipInfo(path.relative_to(source).as_posix(), (1980, 1, 1, 0, 0, 0))
            entry.create_system = 3
            entry.external_attr = 0o100644 << 16
            entry.compress_type = zipfile.ZIP_DEFLATED
            archive.writestr(entry, path.read_bytes(), compresslevel=9)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    pack(args.source, args.output)
