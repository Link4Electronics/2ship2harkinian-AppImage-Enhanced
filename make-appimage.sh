#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/HarbourMasters/2ship2harkinian/refs/heads/develop/mm/linux/2s2hIcon.png
export DESKTOP=https://raw.githubusercontent.com/HarbourMasters/2ship2harkinian/refs/heads/develop/mm/linux/2s2h.desktop
export STARTUPWMCLASS=2s2h.elf
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun ./AppDir/bin/* /usr/bin/zenity

# Turn AppDir into AppImage
quick-sharun --make-appimage
