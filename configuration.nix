{ inputs, pkgs, ... }:

let inherit (inputs) nixpkgs fenix;

in {
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
      keep-derivations = true;
      sandbox = false;
      trusted-users = [ "@wheel" ];
      extra-platforms = [ "aarch64-darwin" "x86_64-darwin" ];
    };
  };

  programs.zsh.enable = true;

  users.users.ludovic = { home = "/Users/ludovic"; };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [{ home.stateVersion = "22.11"; }];

    users.ludovic = { ... }: { imports = [ ./programs ]; };
  };

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
    fenix.overlays.default
  ];

  environment.systemPackages = [
    pkgs.nixfmt
    pkgs.htop
    pkgs.doctl
    pkgs.nodejs-18_x
    pkgs.tmux
    pkgs.kubectl
    pkgs.pandoc
    pkgs.sops
    pkgs.kustomize
    pkgs.fluxcd
    # pkgs.imagemagick6
    pkgs.imagemagick
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
    pkgs.cmake
    pkgs.jsonnet-bundler
    pkgs.jsonnet
    pkgs.nodePackages.ts-node
    pkgs.tree
    pkgs.python310
    pkgs.dsq
    pkgs.terraform
    pkgs.mongodb-tools
    pkgs.redis
    pkgs.dive
    pkgs.poetry
    pkgs.krew
    pkgs.awscli2
    pkgs.aws-iam-authenticator
    pkgs.kubeseal
    pkgs.php82
    pkgs.php82Packages.composer
    pkgs.cmctl
    pkgs.trivy
  ];
}
