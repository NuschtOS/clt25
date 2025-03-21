#!/usr/bin/env bash

if [[ $1 == xyzbook ]]; then
  IP=172.22.99.158
elif [[ $1 == proxy ]]; then
  IP=138.199.231.159
fi

nixos-rebuild switch --flake ".#${1:-xyzbook}" --target-host root@$IP --use-remote-sudo
