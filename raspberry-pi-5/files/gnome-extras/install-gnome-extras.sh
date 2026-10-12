#!/bin/bash
# Installs system-wide Flatpak applications and GNOME Shell extensions in the GNOME extras stage4.
set -euo pipefail

echo "Installing system-wide Flatpak applications and GNOME Shell extensions"

# Flatpak's system installation helper is D-Bus activated. Catalyst runs fsscripts in a chroot
# without a system bus, so provide a temporary one for the install and stop it afterward.
BUS_PID=""
if [ ! -S /run/dbus/system_bus_socket ]; then
    mkdir -p /run/dbus
    dbus-uuidgen --ensure=/etc/machine-id
    BUS_PID=$(dbus-daemon --system --fork --print-pid=1)
fi
cleanup() {
    if [ -n "$BUS_PID" ]; then
        kill "$BUS_PID" 2>/dev/null || true
    fi
}
trap cleanup EXIT

flatpak remote-add --system --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install --system --noninteractive --assumeyes flathub \
    io.github.flattool.Warehouse \
    com.mattjakeman.ExtensionManager

shell_version=$(gnome-shell --version | sed -E 's/.* ([0-9]+)(\..*)?$/\1/')
case "$shell_version" in
    ''|*[!0-9]*) echo "Could not determine GNOME Shell version" >&2; exit 1 ;;
esac

tmp_dir=$(mktemp -d)
trap 'rm -rf -- "${tmp_dir:?}"; cleanup' EXIT

install_extension() {
    local uuid="$1"
    local archive="$tmp_dir/$uuid.zip"
    local destination="/usr/share/gnome-shell/extensions/$uuid"
    curl --fail --location --silent --show-error \
        "https://extensions.gnome.org/download-extension/$uuid.shell_version=$shell_version" \
        --output "$archive"
    mkdir -p "$destination"
    unzip -q "$archive" -d "$destination"
    python3 - "$destination/metadata.json" "$uuid" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as metadata_file:
    metadata = json.load(metadata_file)
if metadata.get("uuid") != sys.argv[2]:
    raise SystemExit(f"Unexpected GNOME extension UUID in {sys.argv[1]}")
PY
    chown -R root:root "$destination"
    chmod -R a+rX,u+w "$destination"
}

install_extension blur-my-shell@aunetx
install_extension dash-to-dock@micxgx.gmail.com
install_extension focus@scaryrawr.github.io
install_extension paperwm@paperwm.github.com

# Compile the machine-wide GNOME defaults shipped in root_overlay.
dconf update
echo "Installed GNOME extras for Shell $shell_version"
