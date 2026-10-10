# Raspberry Pi 5 template for Catalyst Lab

[Catalyst Lab](https://github.com/damiandudycz/catalyst-lab-2) project template that builds Gentoo for Raspberry Pi 5.
Select **From template** when creating a project in Catalyst Lab.

## Stages

```
stage1 ─┬─ stage3 ── stage4                          (console system)
        └─ stage3-desktop ─┬─ stage4-gnome           (if GNOME is selected)
                           └─ stage4-plasma          (if KDE Plasma is selected)
```

stage4 includes the Raspberry Pi kernel and firmware (`sys-kernel/raspberrypi-image`), NetworkManager, SSH, NTP,
cpupower and sudo, with boot configuration in `/boot`.

## Options

| Option | Values |
|---|---|
| Init system | OpenRC, systemd (services are enabled automatically with OpenRC only) |
| CPU optimization | Tuned for Cortex-A76, generic arm64 |
| Link-time optimization (LTO) | Off by default. Includes workarounds for packages that fail with LTO |
| Desktops | GNOME, KDE Plasma (any of them, each gets its own stage4) |
| CPU frequency | 2.4 GHz (stock), 2.6 GHz, 2.8 GHz (needs good cooling) |
| Serial console | UART enabled in `config.txt` |
| zram swap | Disabled, 1, 2 or 4 GB |

Software groups, each applied to selected stage4 stages: Wi-Fi and Bluetooth, Raspberry Pi utilities, development
tools, Docker.

The hostname is generated from the name of the project.

## Notes

- `cmdline.txt` (root device and kernel arguments) isn't created by the template, it depends on the device the system
  is deployed to and is created when deploying.
- Booting from NVMe or USB also needs the boot order in the EEPROM of Raspberry Pi set to try these devices
  (`rpi-eeprom-config`).

## Format

See [Project templates](https://github.com/damiandudycz/catalyst-lab-2/blob/main/docs/project-templates.md).
