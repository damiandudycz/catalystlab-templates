# Gentoo release

Stages built like official Gentoo releases, from releng spec templates: stage1, stage3, stage4 and minimal
installation ISO.

- Architectures: amd64, arm64, arm (ARMv7-A, ARMv6, ARMv5TE, ARMv4T, hard float), ppc, ppc64, ppc64le (POWER9),
  s390x, sparc (SPARC64, SPARC), x86 (i686, i686 with SSE math, i486).
- CPU target: generic baseline by default. amd64 offers x86-64-v2/v3/v4, arm64 offers Armv8.2-A/8.4-A/9-A,
  ppc64 offers POWER8/9, the existing POWER9 option remains available for ppc64le, and s390x offers z13/z15. The Bash build-helper workaround is
  included only for x86-64-v4, where AVX-512 can cause failures under QEMU user emulation. More specific targets require matching
  hardware; x86-64-v4 requires AVX-512.
- Link-time optimization (LTO): optional, stage1 is built with `-flto` added to selected CPU flags, later stages inherit it.
- Init system: OpenRC or systemd. Network: NetworkManager, dhcpcd (OpenRC) or systemd-networkd (systemd).
- Installation ISO: where releng has installcd specs, built from OpenRC stage3.
- Software of stage4: kernel and firmware, GRUB, sudo, vim, administration tools.
