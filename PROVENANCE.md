# Official `main` bucket provenance

Evidence for each package in the official bucket. The Cyberpunk 2077 entries
were inspected 2026-10-31 and 2026-11-07, and the Balatro entries 2026-11-07.
Modn does not mirror or redistribute any of these archives.

## Sources

- **https**: the original GitHub release asset. Its SHA-256 matches the
  `digest` GitHub publishes for that asset and a fresh download.
- **manual**: Nexus Mods only. Nexus requires a signed-in download, and its
  authors have not granted Modn permission to redistribute. Users download
  the named file themselves; the hash was taken from that original download.

| Package | Version | Source | Upstream |
| --- | --- | --- | --- |
| `red4ext` | 1.31.0 | https | [WopsS/RED4ext](https://github.com/WopsS/RED4ext) |
| `redscript` | 0.5.32 | https | [jac3km4/redscript](https://github.com/jac3km4/redscript) |
| `cet` | 1.38.1 | https | [maximegmd/CyberEngineTweaks](https://github.com/maximegmd/CyberEngineTweaks) |
| `archivexl` | 1.28.6 | https | [psiberx/cp2077-archive-xl](https://github.com/psiberx/cp2077-archive-xl) |
| `tweakxl` | 1.12.0 | https | [psiberx/cp2077-tweak-xl](https://github.com/psiberx/cp2077-tweak-xl) |
| `codeware` | 1.21.2 | https | [psiberx/cp2077-codeware](https://github.com/psiberx/cp2077-codeware) |
| `mod-settings` | 0.2.28 | https | [jackhumbert/mod_settings](https://github.com/jackhumbert/mod_settings) |
| `input-loader` | 0.2.6 | https | [jackhumbert/cyberpunk2077-input-loader](https://github.com/jackhumbert/cyberpunk2077-input-loader) |
| `better-loot-markers` | 1.4.1 | https | [rodikh/BetterLootMarkers-Cyberpunk-mod](https://github.com/rodikh/BetterLootMarkers-Cyberpunk-mod) |
| `equipment-ex` | 1.2.10 | manual | [Nexus 6945](https://www.nexusmods.com/cyberpunk2077/mods/6945) |
| `browser-extension` | 0.9.7 | manual | [Nexus 10038](https://www.nexusmods.com/cyberpunk2077/mods/10038) |
| `no-intro-videos` | 0.8 | manual | [Nexus 533](https://www.nexusmods.com/cyberpunk2077/mods/533) |
| `virtual-atelier` | 1.6.4 | manual | [Nexus 2987](https://www.nexusmods.com/cyberpunk2077/mods/2987) |
| `all-vanilla-clothes-atelier-store` | 1.0 | manual | [Nexus 5544](https://www.nexusmods.com/cyberpunk2077/mods/5544) |
| `autoloot` | 3.12.0 | manual | [Nexus 5202](https://www.nexusmods.com/cyberpunk2077/mods/5202) |
| `clean-voiceovers` | r1 | manual | [Nexus 15285](https://www.nexusmods.com/cyberpunk2077/mods/15285) |
| `custom-quickslots` | 5.7.1 | manual | [Nexus 3096](https://www.nexusmods.com/cyberpunk2077/mods/3096) |
| `cyberarms-patch` | 1.4.2 | manual | [Nexus 4393](https://www.nexusmods.com/cyberpunk2077/mods/4393) |
| `hd-reworked-project` | 2.0 | manual | [Nexus 7652](https://www.nexusmods.com/cyberpunk2077/mods/7652) |
| `disclosed-hidden-gems` | 1.1.0 | manual | [Nexus 29021](https://www.nexusmods.com/cyberpunk2077/mods/29021) |
| `drone-companions` | 1.20 | manual | [Nexus 4520](https://www.nexusmods.com/cyberpunk2077/mods/4520) |
| `hide-read-shards` | 0.4 | manual | [Nexus 2820](https://www.nexusmods.com/cyberpunk2077/mods/2820) |
| `limited-hud` | 2.23.1 | manual | [Nexus 2592](https://www.nexusmods.com/cyberpunk2077/mods/2592) |
| `native-settings-ui` | 1.97 | manual | [Nexus 3518](https://www.nexusmods.com/cyberpunk2077/mods/3518) |
| `native-settings-ui-side-menu-add-on` | 1.6.0 | manual | [Nexus 16218](https://www.nexusmods.com/cyberpunk2077/mods/16218) |
| `ping` | 1.4.1 | manual | [Nexus 34933](https://www.nexusmods.com/cyberpunk2077/mods/34933) |
| `preem-scanner` | 1.0.1a | manual | [Nexus 9215](https://www.nexusmods.com/cyberpunk2077/mods/9215) |
| `preem-scopes` | 0.17.2 | manual | [Nexus 10021](https://www.nexusmods.com/cyberpunk2077/mods/10021) |
| `virtual-atelier-delivery` | 1.1.4 | manual | [Nexus 21482](https://www.nexusmods.com/cyberpunk2077/mods/21482) |
| `virtual-car-dealer` | 2.3.0 | manual | [Nexus 4454](https://www.nexusmods.com/cyberpunk2077/mods/4454) |
| `weather-probability-rebalance` | 2.10 | manual | [Nexus 3196](https://www.nexusmods.com/cyberpunk2077/mods/3196) |

On 2026-11-07, eighteen packages were added from the owner's local downloads.
Their SHA-256 values were computed from those files, and each `manual` source
names the exact downloaded filename. Each archive previewed as `reviewable`
with the first-party Cyberpunk policy in a disposable fixture that supplied the
framework markers. They were not installed into a live game in this change.

The Cyber Engine Tweaks and Input Loader GitHub assets are byte-identical to
their Nexus files. The BetterLootMarkers GitHub release 1.4.1 is newer than
the Nexus 1.4.0 file that was inspected.
Equipment-EX is published as manual because the newest GitHub release, 1.2.7
from 2024, predates game 2.5; 1.2.10 is on Nexus only.

## Declared executables

`redscript` declares `engine/tools/scc.exe`, the script compiler shipped in its
original Windows ZIP. No other package installs an executable.

## Dependencies

Dependencies list what the upstream author documents as required, plus
anything the inspected archive needs to load. Optional integrations are left
out. Nexus requirement tables block automated fetches; the Nexus entries below
were read by the reviewer of this snapshot.

- `cet`: the v1.38.1 README says to install RED4ext first.
- `archivexl`, `tweakxl`, `codeware`: their READMEs require RED4ext 1.31.0+
  and list redscript 0.5.32+ for compatibility. Each ships `.reds` scripts.
  Their manifests declare both as `dependency_versions`.
- `mod-settings`: its README requires RED4ext and redscript. It also ships
  `ModSettings.archive.xl`, which ArchiveXL loads.
- `equipment-ex`: its README requires ArchiveXL, TweakXL, Codeware and
  redscript. Its scripts check for ArchiveXL 1.28.0 and TweakXL 1.12.0, which
  its manifest declares as `dependency_versions`.
- `virtual-atelier`: imports `Codeware.UI` unconditionally and ships an
  `.archive.xl`, so it needs Codeware and ArchiveXL. Its Nexus page also
  requires Mod Settings, which configures it through `@runtimeProperty`
  annotations. Browser Extension, Equipment-EX and Atelier Delivery support
  is `@if(ModuleExists(...))`, so it is optional.
- `browser-extension`: its Nexus page requires redscript, RED4ext and
  Codeware. Its Mod Settings support is conditional.
- `no-intro-videos`: one redscript source file.
- `input-loader`: its README says to install RED4ext first, and its release
  requirements list RED4ext 1.31.0+, which the manifest declares as a
  `dependency_version`.
- `better-loot-markers`: its README requires Cyber Engine Tweaks 1.34.1+, which
  its manifest declares as a `dependency_version`.

The 2026-11-07 packages declare the framework that their inspected layout
needs: redscript for `.reds` sources and hints, ArchiveXL for `.xl` metadata,
TweakXL for `.yaml` tweaks, Input Loader for `r6/input` XML, and CET for CET
mods. `all-vanilla-clothes-atelier-store` also requires Virtual Atelier.
`disclosed-hidden-gems`, `ping`, `virtual-atelier-delivery` and
`virtual-car-dealer` import Codeware. `virtual-atelier-delivery` requires
Virtual Atelier 1.4.7 or newer, and `native-settings-ui-side-menu-add-on`
requires Native Settings UI. Mod Settings and Native Settings UI integrations
in these archives are conditional and are not declared as dependencies.

No upstream source documents a conflict between these packages, so no manifest
declares `conflicts`.

## Packages not added

The owner's 2026-11-07 download batch also contained packages that the bucket
does not include:

- `Let There Be Flight` 0.3.20 (Nexus 5208) ships
  `red4ext/plugins/let_there_be_flight_uninstall.bat`. Modn blocks it as an
  unapproved executable payload in an unrecognized layout
  (`EXECUTABLE_PAYLOAD`, `UNRECOGNIZED_LAYOUT`).
- `Clean Inventory` 3.4.0 (Nexus 34413) ships
  `r6/scripts/CleanInventory/FRIDGE-COMPATIBILITY.txt`. The redscript layout
  accepts only `.reds` files and recognized documentation names, so the
  preview blocks the whole package with `UNSUPPORTED_CONTENT`.
- `Nearby Auto Loot` 1.1.1 (Nexus 34650) ships
  `r6/scripts/DimaNearbyAutoLoot/CREDITS.txt` and `VERSION.txt`. The same
  redscript document-name rule blocks it with `UNSUPPORTED_CONTENT`.
- `Arasaka Cyberarms` 4.8.1 (Nexus 1099) is a `.rar` file. The bucket contract
  supports ZIP and 7z archives only.
- `ArchiveXL` 1.28.3, `BetterLootMarkers` 1.4.0, `Codeware` 1.21.1 and
  `Mod Settings` 0.2.27 were older copies. The bucket already publishes newer
  current releases, so the older files were not added.

## Compatibility

The ArchiveXL, TweakXL and Codeware READMEs target Cyberpunk 2077 2.5. The CET
and Mod Settings Nexus files are labeled for game 2.5/2.50. On 2026-11-02 all
eleven packages installed, launched and uninstalled on a live Steam
installation that reports game version 3.0.88.46235 (project memory
finding `PM-20261102-ade7fa3a`).

The Input Loader and BetterLootMarkers packages were exercised only in the
disposable fixture below, not on a live installation.

In a disposable fixture, the original thirteen archives install through the
first-party Cyberpunk policy in dependency order: 147 owned files. The eleven
original archives own 137 of them.
Uninstalling in reverse order restores the fixture. The milestone 3 gate
(`apps/modn-cli/tests/milestone_gate.rs`) repeats this through catalog stack
installs, which download the `https` archives, and adds rollback and recovery
checks. It compares the whole tree, directories included: uninstall and
rollback also remove the empty directories that Modn created.

## Balatro

| Package | Version | Source | Upstream | License | Pin |
| --- | --- | --- | --- | --- | --- |
| `lovely` | 0.10.0 | github-release | [ethangreen-dev/lovely-injector](https://github.com/ethangreen-dev/lovely-injector) | MIT | tag `v0.10.0`, asset `lovely-x86_64-pc-windows-msvc.zip`, SHA-256 `7f481f984ab8ee633c90ce18220c88a2da8f93ca86b6c3e3ff70a725c05807ab` |
| `steamodded` | 26.1002.0 | git | [Steamodded/smods](https://github.com/Steamodded/smods) | GPL-3.0 | tag `26.1002.0`, commit `af0fdb1eb2c9e191262c128bc88bbc4da991e12d` |

The `lovely` SHA-256 matches the GitHub release asset digest and a fresh
download of the Windows ZIP. Lovely is a native injector: it installs
`winmm.dll` beside `Balatro.exe`, so its manifest sets `native_injector` and
Modn requires explicit approval before installing it.

Steamodded has no redistributed archive. Modn fetches the pinned commit from
`Steamodded/smods` and installs the tree under the Balatro content root
(`%APPDATA%/Balatro/Mods/smods/`). Its manifest declares `lovely` as a
dependency, because Steamodded loads through the Lovely injector.
