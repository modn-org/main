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
`.github/modn-ref`. It then checks that `modn search` lists every manifest.

## Game modules

Each `module.json` declares the host API version (`api_version`) that its
module needs. A Modn that does not support that version refuses the whole
bucket, and `modn bucket update` keeps the previous copy. Change
`api_version` only after a Modn release supports the new version. Then change
`.github/modn-ref` to that release.

## Releasing

Push a tag `vYYYY.MM.DD` from `main` (add `.N` for a second release on the
same day). CI validates the tagged commit and publishes the release with
`main-bucket.zip` and its checksum.

Run the checks locally with a modn build:

```sh
python .github/scripts/validate.py . path/to/modn dist
```
