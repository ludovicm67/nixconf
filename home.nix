{ inputs, pkgs, ... }:

let inherit (inputs) nixpkgs;

in {
  imports = [ ./programs ];

  nixpkgs.overlays = [
    (final: prev:
      let
        inherit (prev) config;
        x86Pkgs = import nixpkgs {
          inherit config;
          localSystem = "x86_64-darwin";
        };
      in if prev.stdenv.system == "aarch64-darwin" then {
        inherit (x86Pkgs) nix-index;
      } else
        { })
  ];

  home.packages = [
    pkgs.nixfmt
    pkgs.htop
    pkgs.doctl
    pkgs.nodejs-16_x
    pkgs.tmux
    pkgs.kubectl
    pkgs.pandoc
    pkgs.sops
    pkgs.kustomize
    pkgs.fluxcd
    pkgs.imagemagick6
  ];
}
