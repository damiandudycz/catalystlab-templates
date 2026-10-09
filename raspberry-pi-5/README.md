# Raspberry Pi 5 template for Catalyst Lab

[Catalyst Lab](https://github.com/damiandudycz/catalyst-lab-2) project template that builds Gentoo for Raspberry Pi 5.
Select **From template** when creating a project in Catalyst Lab.

## Stages

```
stage1 ─┬─ stage3 ── stage4                (console system)
        └─ stage3-desktop ── stage4-<desktop>   (optional GNOME or KDE Plasma)
```

stage4 includes the Raspberry Pi kernel and firmware (`sys-kernel/raspberrypi-image`), NetworkManager, SSH, NTP,
cpupower and sudo, with boot configuration in `/boot`.

## Options

| Option | Values |
|---|---|
| Init system | OpenRC, systemd (services are enabled automatically with OpenRC only) |
| CPU optimization | Tuned for Cortex-A76, tuned with LTO (includes workarounds for packages that fail with LTO), generic arm64 |
| Desktop | None, GNOME, KDE Plasma |
| Root filesystem | microSD card, NVMe drive, USB drive (root device in `cmdline.txt`) |
| PCIe Gen 3 | For NVMe drives |
| CPU frequency | 2.4 GHz (stock), 2.6 GHz, 2.8 GHz (needs good cooling) |
| Serial console | Console on UART |
| zram swap | Disabled, 1, 2 or 4 GB |

Software groups, each applied to selected stage4 stages: Wi-Fi and Bluetooth, Raspberry Pi utilities, development
tools, Docker.

The hostname is generated from the name of the project.

## Notes

- Booting from NVMe or USB also needs the boot order in the EEPROM of Raspberry Pi set to try these devices
  (`rpi-eeprom-config`), the template configures only the system.
- Root partition is expected to be the second partition of the device, with ext4 filesystem, and boot partition the
  first one.

## Format

See [Project templates](https://github.com/damiandudycz/catalyst-lab-2/blob/main/docs/project-templates.md).
