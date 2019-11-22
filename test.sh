#!/usr/bin/env bash

set -e

declare -A packages
packages[gtk2]="lxappearance"
packages[gtk3]="lxappearance-gtk3"

if [ -z "${packages[$1]}" ]; then
    echo "This will potentially modify your /home directory."
    echo "You probably want to examine this script before running it."
    echo "Then, run either of:"
    echo " ./test.sh gtk2"
    echo " ./test.sh gtk3"
    exit 1
fi

mkdir -p ~/.themes
rm ~/.themes/Yaru-dracula || true
ln -sf "$(pwd)/result/share/themes/Yaru-dark" ~/.themes/Yaru-dracula

nix-build .
nix-shell -p "${packages[$1]}" --run "GTK_DEBUG=interactive lxappearance"
