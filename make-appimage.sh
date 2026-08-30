#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/Rainchus/Donkey-Kong-64-Recompiled/refs/heads/main/icons/app.png
export DESKTOP=https://raw.githubusercontent.com/Rainchus/Donkey-Kong-64-Recompiled/refs/heads/main/.github/linux/DK64Recompiled.desktop
export STARTUPWMCLASS=DK64Recompiled
export DEPLOY_VULKAN=1

# Deploy dependencies
quick-sharun ./AppDir/bin/DK64Recompiled
echo 'SHARUN_WORKING_DIR=${SHARUN_DIR}/bin' >> ./AppDir/.env

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
