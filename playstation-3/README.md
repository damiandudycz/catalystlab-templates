# PlayStation 3

Gentoo for PlayStation 3, based on the configuration from the first version of Catalyst Lab.

```
stage1 ─┬─ stage3 ── stage4                         (console system)
        └─ stage3-desktop ── stage4-desktop-xfce    (optional, OpenRC)
```

- Stages are built for Cell CPU (`cell` subarch, AltiVec), optionally with LTO.
- stage4 includes PS3 kernel (`sys-kernel/gentoo-kernel-ps3`), video memory swap (`ps3vram-swap`) and `ps3pf_utils`,
  NetworkManager, SSH and NTP. Optional zram swap, development tools and PS3 Gentoo installer.
- PS3 packages come from [ps3-gentoo-overlay](https://github.com/damiandudycz/ps3-gentoo-overlay), which is added to
  Catalyst Lab when the project is created.

Not included yet: installation ISO (livecd-stage2). It needs kernel options of Catalyst (`boot/kernel/<name>/...`),
which Catalyst Lab doesn't support in stages yet.
