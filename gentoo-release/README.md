# Gentoo release

Stages built like official Gentoo releases, from releng spec templates: stage1, stage3, stage4 and minimal
installation ISO.

- Architectures: amd64, arm64, arm (ARMv7-A, ARMv6, ARMv5TE, ARMv4T, hard float), ppc, ppc64, ppc64le (POWER9),
  s390x, sparc (SPARC64, SPARC), x86 (i686, i686 with SSE math, i486).
- Link-time optimization (LTO): optional, stage1 is built with `-flto` added to default flags of the subarch,
  later stages inherit it.
- Init system: OpenRC or systemd. Network: NetworkManager, dhcpcd (OpenRC) or systemd-networkd (systemd).
- Installation ISO: where releng has installcd specs, built from OpenRC stage3.
- Software of stage4: kernel and firmware, GRUB, sudo, vim, administration tools.
