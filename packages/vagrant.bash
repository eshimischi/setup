#!/usr/bin/env bash

set -e

# Title
echo "Setup Vagrant plugins"

PLUGINS=(
  "vagrant-cachier"
  "vagrant-vbguest"
  "vagrant-bindfs"
  "vagrant-hostmanager"
)

if which vagrant > /dev/null 2>&1; then
  INSTALLED_PLUGINS=$(vagrant plugin list)
  for PLUGIN in "${PLUGINS[@]}"; do
    if ! echo "${INSTALLED_PLUGINS}" | grep "${PLUGIN} (" > /dev/null 2>&1; then
      vagrant plugin install "${PLUGIN}"
    fi
  done

  vagrant plugin update
fi