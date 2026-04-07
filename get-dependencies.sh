#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    cmake         \
    fmt           \
    libdecor      \
    libzip        \
    lsb-release   \
    ninja         \
    nlohmann-json \
    opus          \
    sdl2          \
    sdl2_net      \
    spdlog        \
    tinyxml2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
make-aur-package zenity-rs-bin

# If the application needs to be manually built that has to be done down here
echo "Making stable build of 2ship2harkinian..."
echo "---------------------------------------------------------------"
REPO="https://github.com/HarbourMasters/2ship2harkinian"
VERSION="$(git ls-remote --tags --sort="v:refname" "$REPO" | tail -n1 | sed 's/.*\///; s/\^{}//')"
git clone --branch "$VERSION" --single-branch --recursive --depth 1 "$REPO" ./2ship2harkinian
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./2ship2harkinian
cmake . \
    -Bbuild \
    -GNinja \
    -DNON_PORTABLE=On
cmake --build build --config Release
cmake --build build --config Release --target GenerateO2R

mv -v build/assets ../AppDir/bin
mv -v build/2s2h.elf ../AppDir/bin
mv -v build/2ship.o2r ../AppDir/bin
wget -O ../AppDir/bin/gamecontrollerdb.txt https://raw.githubusercontent.com/mdqinc/SDL_GameControllerDB/master/gamecontrollerdb.txt
cp -rv icon.png /usr/share/pixmaps/2s2h.png
