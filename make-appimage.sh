#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q 2s2h | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/pixmaps/2s2h.png
export DESKTOP=/usr/share/applications/2s2h.desktop
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/2s2h /usr/bin/2s2h-otr-exporter

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
