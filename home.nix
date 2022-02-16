{ inputs, pkgs, ... }:

let inherit (inputs) nixpkgs fenix;

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
    fenix.overlay
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
    pkgs.postgresql
    pkgs.kubernetes-helm
    pkgs.yarn
    pkgs.pwgen
    pkgs.tokei
    pkgs.pv
    pkgs.jq
    (pkgs.fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    pkgs.rust-analyzer-nightly
    pkgs.minio-client
    pkgs.wrk
    pkgs.maven
    pkgs.jdk17
  ];
}
