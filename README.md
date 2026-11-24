# Modn main bucket

This repository is the official `main` bucket of
[Modn](https://github.com/modn-org/modn). It holds the mod package manifests,
the first-party Lua game modules and the official game themes. The bucket
contract is in Modn's
[`buckets/README.md`](https://github.com/modn-org/modn/blob/main/buckets/README.md).

```text
bucket.json
PROVENANCE.md
mods/<game-id>/<package-id>.json
games/<game-id>/module.json
games/<game-id>/module.lua
themes/<game-id>/<theme-id>/
```

`bucket.json` declares bucket contract v2. Each package manifest pins its
archive with BLAKE3 and lists its artifact sources in `sources`. A record lists
either `git` sources or archive sources, never both.

`modn bucket update` downloads `main-bucket.zip` and `main-bucket.zip.minisig`
from the latest release of this repository. The signature is a minisign
signature over the catalog statement: the bucket name and a BLAKE3 digest of
the extracted files. Modn verifies it with the signer key built into Modn and
refuses an unsigned release. A bucket change does not need a Modn release.

## Adding a package

Add `mods/<game-id>/<package-id>.json` and a row in `PROVENANCE.md`. Open a
pull request. CI packs the bucket and installs it with the modn revision in
`.github/modn-ref`. It checks that `modn search` lists every manifest. It then
runs `modn install main/<game-id>/<package-id> --dry-run` for every package
against a fake installation, so each dependency and version requirement must
resolve. A new game needs its installation marker in `GAME_MARKERS` in
`.github/scripts/validate.py`. `selftest.py` checks that validation rejects a
future host API, a missing dependency and an unsatisfied version requirement.

The ZIP bytes repeat for the same Python and zlib build. Other zlib builds can
compress differently, so only CI publishes the release ZIP.

## Themes

`themes/<game-id>/<theme-id>/` holds `theme.json`, `theme.css`, optional
`theme.<variant>.css` files and `assets/`. The contract is in Modn's
[`docs/themes.md`](https://github.com/modn-org/modn/blob/main/docs/themes.md).
CI runs `modn theme check` on every theme. The official Cyberpunk 2077 theme is
`themes/cyberpunk-2077/night-city/`.

Theme text uses LF line endings and PNG and WOFF2 assets are binary, because
the theme digest covers file bytes. `.gitattributes` enforces both.

## Game modules

Each `module.json` declares the host API version (`api_version`) that its
module needs. Bucket contract v2 uses host API 3. A Modn that does not support
that version refuses the whole bucket, and `modn bucket update` keeps the
previous copy. Change `api_version` only after Modn `main` supports the new
version. Then update `.github/modn-ref`.

API 3 adds an optional `content_root`: a safe relative path below `%APPDATA%`
where a game keeps its mods. Balatro declares `Balatro/Mods`, so its packages
plan files under the content root, and scan and doctor report content-root
entries separately from the game root. An API 3 module without `content_root`
keeps the game-root behavior.

The optional `min_modn_version` declares a minimum Modn release as a complete
semantic version, without operators or wildcards. Cyberpunk requires Modn 0.3.0
for REDmod `json-object` validation. Clients with this feature report the
required and running versions. Released Modn 0.2.0 refuses the unknown field.
Balatro declares 0.4.0 for its content root. Signed releases need Modn 0.5.0:
earlier releases cannot verify `main-bucket.zip.minisig`. The `stores` and
`launch` fields need Modn 0.6.0: earlier releases refuse them as unknown fields.
`.github/modn-ref` pins the current Modn `main` commit, which supports bucket
contract v2 and host API 3.

## Releasing

Push a tag `vYYYY.MM.DD` from `main` (add `.N` for a second release on the
same day). CI validates the tagged commit. It then computes the catalog
statement with Modn's `catalog_digest` example and signs it with minisign. The
secret key and its password are the `MINISIGN_SECRET_KEY` and
`MINISIGN_PASSWORD` Actions secrets. A production build of the pinned Modn must
accept the signed ZIP before CI publishes `main-bucket.zip` and
`main-bucket.zip.minisig`. Signing and publishing are maintainer steps.

Pull requests never use the secrets. Validation signs a copy of the ZIP with an
ephemeral key, so it needs a modn build with the `test-main-key` feature and
the `sign_catalog` example. Run the checks locally from a modn checkout:

```sh
cargo build --locked -p modn-cli --features modn-core/test-main-key
cargo build --locked -p modn-core --example sign_catalog
python .github/scripts/validate.py . path/to/modn path/to/sign_catalog dist
python .github/scripts/selftest.py . path/to/modn path/to/sign_catalog
```
