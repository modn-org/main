# Modn main bucket

This repository is the official `main` bucket of
[Modn](https://github.com/modn-org/modn). It holds the mod package manifests and
the first-party Lua game modules. The bucket contract is in Modn's
[`buckets/README.md`](https://github.com/modn-org/modn/blob/main/buckets/README.md).

```text
bucket.json
PROVENANCE.md
games/<game-id>/<package-id>.json
games/<game-id>/module.json
games/<game-id>/module.lua
```

`modn bucket update` downloads `main-bucket.zip` and `main-bucket.zip.sha256`
from the latest release of this repository. A bucket change does not need a
Modn release.

## Adding a package

Add `games/<game-id>/<package-id>.json` and a row in `PROVENANCE.md`. Open a
pull request. CI packs the bucket and installs it with the modn revision in
`.github/modn-ref`. It checks that `modn search` lists every manifest. It then
runs `modn install main/<game-id>/<package-id> --dry-run` for every package
against a fake installation, so each dependency and version requirement must
resolve. A new game needs its installation marker in `GAME_MARKERS` in
`.github/scripts/validate.py`. `selftest.py` checks that validation rejects a
future host API, a missing dependency and an unsatisfied version requirement.

The ZIP bytes repeat for the same Python and zlib build. Other zlib builds can
compress differently, so only CI publishes the release ZIP.

## Game modules

Each `module.json` declares the host API version (`api_version`) that its
module needs. A Modn that does not support that version refuses the whole
bucket, and `modn bucket update` keeps the previous copy. Change
`api_version` only after a Modn release supports the new version. Then change
`.github/modn-ref` to that release.

API 2 adds an optional `content_root`: a safe relative path below `%APPDATA%`
where a game keeps its mods. Balatro declares `Balatro/Mods`, so its packages
plan files under the content root, and scan and doctor report content-root
entries separately from the game root. An API 2 module without `content_root`
keeps the game-root behavior.

The optional `min_modn_version` declares a minimum Modn release as a complete
semantic version, without operators or wildcards. Cyberpunk requires Modn 0.3.0
for REDmod `json-object` validation. Clients with this feature report the
required and running versions. Released Modn 0.2.0 refuses the unknown field.
The bucket needs Modn 0.3.0 before it can pass validation or be published.

## Releasing

Push a tag `vYYYY.MM.DD` from `main` (add `.N` for a second release on the
same day). CI validates the tagged commit and publishes the release with
`main-bucket.zip` and its checksum.

Run the checks locally with a modn build:

```sh
python .github/scripts/validate.py . path/to/modn dist
python .github/scripts/selftest.py . path/to/modn
```
