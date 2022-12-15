#!/bin/sh

nix flake update
darwin-rebuild switch --flake .
