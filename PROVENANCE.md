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

## Rehash to contract v2

`rehash_main.py` converted 33 packages to bucket contract v2 on 2026-11-24 (UTC).
Each archive was verified against its old SHA-256 pin before `modn catalog hash`
printed its BLAKE3 pin. Git-only records keep their commit pin and have no archive digest.

| Package | Old SHA-256 | New BLAKE3 |
| --- | --- | --- |
| `balatro/lovely` | `7f481f984ab8ee633c90ce18220c88a2da8f93ca86b6c3e3ff70a725c05807ab` | `c811206f1421ece0ce272edd243364b908bfbd3f1062355b5c5cc35af7f2a4ac` |
| `balatro/steamodded` | git source | git commit pin |
| `cyberpunk-2077/all-vanilla-clothes-atelier-store` | `041b2358935e2520427343046074abf19f59dcad7d9d789d93d3f81b683fb423` | `9fb844b3508923101055d8b09f43ed4d715b6c02c74246afb8e9392beaee4399` |
| `cyberpunk-2077/archivexl` | `25d0493a1b3e8ec4c26b7144a4d8f1a1def4d6dc840fff94b4c91c908583da09` | `cbf137f3123ff10eaf008e9953ebb67f2dc6bcd500a7073d837f29a5ed0176f4` |
| `cyberpunk-2077/autoloot` | `0ed67b61ad2afc6a124445b5d2394f2d81daea91a8e5750e97f31a319bf6e1a9` | `72cd57d8358a5cc4f88bfa6dc383ab8c8799673a84439c70302a8b465fcc7d13` |
| `cyberpunk-2077/better-loot-markers` | `e0f77b22e12f913929b31baa0e442833ae9c9a196718d3bb5bf4a9cd15cb3d49` | `12ead61dcd18d058da81f48c28c45fdf1554b545b092ebd6d676ed6bde007fe0` |
| `cyberpunk-2077/browser-extension` | `c290f0db802a00233e8f70f218248abdc6acdbe3348eceb484f33e2e1a75087d` | `f4de69ff8d26db98e4e850f9e4df87162d279a684b17459e2aa83d9f3f82cecc` |
| `cyberpunk-2077/cet` | `2e52be4ed431fad787e64ecbf75db346b4224577d2b89894912bc3f159020e73` | `8b81ebcd75af7c8322cb2fa06ddd3e00bc77cd3eb84b0cd7fcb1e36563d86dd7` |
| `cyberpunk-2077/clean-voiceovers` | `a3ed0abda2a921acb341b6d7e08b3df70bf90407d49f2be2139a65ece567c15d` | `9cd0c1595a1f3886a5ce00b172e3bbb991a77d679fd85b54365835973961136f` |
| `cyberpunk-2077/codeware` | `269b65b8b97d26ea85d4516f5eb34c01a19dc85e299be57fb4f764e16c164dd2` | `28785048cf3152bc73aff7b2ad4a37f20cbf8a46a75c0d33b6fb563da882afdd` |
| `cyberpunk-2077/custom-quickslots` | `988a229108495aed4052582363f006521e809bb03e1486bd02eed0dccb8c0c1c` | `056fbe325f25a04e15f5094ef2037c83bbb8afd066cec0411f336a3b6dad7798` |
| `cyberpunk-2077/cyberarms-patch` | `600438d4b7ae20b865e55c7d2bf3362aec62285c79cbcb7694f3d24e1a61b8b8` | `4a053800992065d2acf75aee4446f896c995278cdf01ad06366e909f4ede0e42` |
| `cyberpunk-2077/disclosed-hidden-gems` | `a5edd0200eab1560fdebd2608e488819e689b6fc1e2913f67b85b479abf9c5ba` | `8b351d88d9e80951167e6fcf8eae2f1b81bf2d74cdb8b9827c11344d71919a56` |
| `cyberpunk-2077/drone-companions` | `6c6454fe0c63e0cbd9fc363674bce1a6bf003d3cd73327e8f5f25355f5ded83e` | `0b1e828ac282f02dcd0a992c0ec4ffcc8ca3fc81cf790fd4581a73109cdd20c4` |
| `cyberpunk-2077/equipment-ex` | `bd3628af0851af4cc5083e40f890e9e7423305cb7e3017f48f9e06a8bc6b6e17` | `5dbc56dd57e9295f21b27a32a0b6c5df4396b07e1492558c24be08e926f0237d` |
| `cyberpunk-2077/hd-reworked-project` | `3569925c14b5ae9dad937673b0af995f7e63e8d2ad3b999aa0b8f7c740998e08` | `c8c93e668061279461de9e23561f98fd8d76b2444655d8913ec390cce1c75d55` |
| `cyberpunk-2077/hide-read-shards` | `d3a31e5a6837af4b0df31c57e2b6951455c6918c464371cf9e4a673854622a88` | `9611e038552d855ea9102bd375fb53006cce132cfb155cc9c2984414ef479c43` |
| `cyberpunk-2077/input-loader` | `6b420ba1e27b2e13c275a576a37a17d48771a0d35e52731f08e3584444a3e2b9` | `16213be32efbb5794ed37bb4ea7b316c778562bfdad31d119fb85569b7792fff` |
| `cyberpunk-2077/limited-hud` | `8920cbfce0b7c57c0f879f7925aafa2ab920c8d92cdcd8c405757f2bdf890c7a` | `89034978d2cd8fc2a5f2494a7f944a0c30dd218e3356ebcbb3365e0f5776ec0b` |
| `cyberpunk-2077/mod-settings` | `b9488daa7da85c0430853df4570dbf94dd768d11c4dabee97d732072746d40e7` | `77a58eb48fdcddec17fe51d27fbcdaae3d10ed3c9c321dbcbbeca28c815bf3c4` |
| `cyberpunk-2077/native-settings-ui-side-menu-add-on` | `8f50d4db5c5718c02a19eed27a1c5bfdf21f72f556e353aaa783ce5c6ef05bf6` | `048c5a46adb802985a6fb2001f8546e821fccec4deaaf5bd26a93c5d86a21060` |
| `cyberpunk-2077/native-settings-ui` | `8f9c6f5b0ef193f088376e738634449179b9f333c26610fbbcd0b17a14dbfb90` | `1333ecb656a783ac8c45de8449b9a48beeda705e3cc644d49199b4d6bd203b45` |
| `cyberpunk-2077/no-intro-videos` | `6d5d0ef603466da3544867b84f946d2f0cd9c3bcd2ad3490fb60e2d601388aef` | `ed855eb9a039126864bab04cc6b8b117259aab9b870add7e0e2788ac8973bfc3` |
| `cyberpunk-2077/ping` | `8c30560583f7d8e63dc2466ee3d287ed9394c4ecaec25187cd01b8e437027544` | `decb03f155225e737a34c4af2e4988fafb82df043afa727cb7a7a475c24d2d21` |
| `cyberpunk-2077/preem-scanner` | `2c09a98af40853dbf70206b584967d922aee72674edc2ce5f430ce6eede0a1e0` | `d487379d091c77ee9364cd6adaf641c47e662c62092aa7dcb030d097e48a5ece` |
| `cyberpunk-2077/preem-scopes` | `b7a45788f7effc66d8a6b2ac7a7d701621ef40ba60b28c10aab01e2f57a04ed3` | `7b4c29b1cbff8ecf11199de7aca7b5ef133a4882169eedff91a1c20b5c571dcb` |
| `cyberpunk-2077/red4ext` | `b9ae4351f547f90af58dfbf7445d45c55cd5ba24fbee27fb16fb5d91e9df621e` | `0702ab607c8269acdd3ad7113bddf950118714824a08459b3e5d9a766bcfb9c4` |
| `cyberpunk-2077/redscript` | `882c57a80b07e453bc8a34cd8430f460aceed789581de8743638e19dcfb7936f` | `dc1e6b17595832d5c95b72ac3f3ef596688827a93588c58fe474db5617ad608e` |
| `cyberpunk-2077/tweakxl` | `a7c39b769e6c51d9f27412a101fb87e6a1fb8452f0e37ee0d1d1f3f44e656fa8` | `f716680cfd41458f43a808697d2b96e3f1f0a6881992b5fcc95d0fe6894bbf45` |
| `cyberpunk-2077/virtual-atelier-delivery` | `65d87b33af91c5704cea00c656bec7a7bd3148d7cb8a9a466fe54190e008b457` | `9234e3f0b39556e1fda92dd01034ffe16e87bebb606012fdd107e3d86f971e91` |
| `cyberpunk-2077/virtual-atelier` | `c0f27177a5f4d40f97923b775d8ab14d553f1d412940ac5bff9a9479717a6f7f` | `c53f97ce2c6a038c7f097aa5a3ecc80e8196efc005705dc1332ed3c2da94a27d` |
| `cyberpunk-2077/virtual-car-dealer` | `a161a4b0af082bf4cb83ae0badf35136ef37134330e949e1dfb587abcfaa913b` | `6d23bc66054011eeebaebd6dc6633533addb26f612ed737ad155821260837c0c` |
| `cyberpunk-2077/weather-probability-rebalance` | `e565255db10053bf1feb0c4b6373bce7a631b14191401278475d7f186d6ee10a` | `d307d51f8ef3192fb1a3bb70f6aefe27445d698e049132c7fe19ee7e47b71894` |
