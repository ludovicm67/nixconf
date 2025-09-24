#!/bin/sh

nix flake update
sudo darwin-rebuild switch --show-trace --flake .
