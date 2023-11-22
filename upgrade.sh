#!/bin/sh

nix flake update
darwin-rebuild switch --show-trace --flake .
