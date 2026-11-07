"""Validate the main bucket with a modn binary and write its release ZIP."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import tempfile

from pack import pack

GAME_MARKERS = {
    "cyberpunk-2077": "bin/x64/Cyberpunk2077.exe",
    "balatro": "Balatro.exe",
}


class ValidationError(Exception):
    pass


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValidationError(message)


def current_releases(bucket: Path) -> set[tuple[str, str]]:
    return {
        (path.parent.name, path.stem)
        for path in (bucket / "games").glob("*/*.json")
        if path.name != "module.json" and "@" not in path.stem
    }


def validate(bucket: Path, modn_binary: Path, output: Path) -> str:
    archive = output.resolve() / "main-bucket.zip"
    pack(bucket, archive)
    with tempfile.TemporaryDirectory() as work:
        work = Path(work)
        repeat = work / "repeat.zip"
        pack(bucket, repeat)
        require(repeat.read_bytes() == archive.read_bytes(), "packing is not deterministic")
        env = {key: value for key, value in os.environ.items() if not key.startswith("MODN_")}
        env["LOCALAPPDATA"] = str(work / "data")
        env["APPDATA"] = str(work / "appdata")
        (work / "appdata").mkdir()
        env["MODN_MAIN_BUCKET_SOURCE"] = str(archive)

        def modn(*command: str):
            result = subprocess.run(
                [str(modn_binary.resolve()), "--json", "--state-dir", str(work / "state"),
                 *command],
                env=env, capture_output=True, text=True, check=False)
            require(result.returncode == 0, f"modn {' '.join(command)}: {result.stderr.strip()}")
            return json.loads(result.stdout)

        require(modn("bucket", "update")["changed"], "first update reported no change")
        require(not modn("bucket", "update")["changed"], "repeated update reported a change")
        listed = {(p["game"], p["id"]) for p in modn("search") if p["bucket"] == "main"}
        expected = current_releases(bucket)
        require(listed == expected, f"search differs from manifests: {sorted(listed ^ expected)}")
        games = sorted({game for game, _ in expected})
        for game in games:
            require(game in GAME_MARKERS, f"no installation marker for {game} in validate.py")
            marker = work / "games" / game / GAME_MARKERS[game]
            marker.parent.mkdir(parents=True, exist_ok=True)
            marker.write_bytes(b"validation fixture")
        for game, package in sorted(expected):
            reference = f"main/{game}/{package}"
            plan = modn("install", reference, "--dry-run", "--path", str(work / "games" / game))
            require(plan["package"] == reference, f"{reference} planned {plan['package']}")
    return f"Validated {len(expected)} packages for {len(games)} games: {', '.join(games)}"


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("bucket", type=Path)
    parser.add_argument("modn", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    try:
        print(validate(args.bucket, args.modn, args.output))
    except ValidationError as error:
        raise SystemExit(f"bucket validation failed: {error}") from None


if __name__ == "__main__":
    main()
