{ inputs, pkgs, ... }:

let
  inherit (inputs) nixpkgs nixpkgs-stable fenix;
  inherit (pkgs) system;
  stable-pkgs = (import nixpkgs-stable {
    inherit system;
    config = { allowUnfree = true; };
  }).pkgs;

in {
  system.stateVersion = 5;
  ids.gids.nixbld = 30000;
  nixpkgs.config.allowUnfree = true;
  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

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
  users.users.ludovic.shell = pkgs.zsh;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [{ home.stateVersion = "24.05"; }];

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
    pkgs.nodejs_22
    pkgs.tmux
    pkgs.kubectl
    pkgs.pandoc
    pkgs.sops
    pkgs.kustomize
    pkgs.fluxcd
    # pkgs.imagemagick6
    pkgs.imagemagick
    pkgs.postgresql_15
    pkgs.kubernetes-helm
    pkgs.yarn
    pkgs.pwgen
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
    pkgs.go-jsonnet
    pkgs.nodePackages.ts-node
    pkgs.tree
    (pkgs.python310.withPackages (ps: with ps; [ pip numpy toolz ]))
    pkgs.gst_all_1.gstreamer
    pkgs.ffmpeg_4
    pkgs.dsq

    pkgs.mongodb-tools
    pkgs.redis
    pkgs.dive
    pkgs.krew
    pkgs.aws-iam-authenticator
    pkgs.kubeseal
    pkgs.php82
    pkgs.php82Packages.composer
    pkgs.cmctl
    pkgs.trivy
    pkgs.miller
    pkgs.wget
    pkgs.pkg-config
    # pkgs.bats
    pkgs.graphicsmagick
    pkgs.gradle
    pkgs.hey
    pkgs.go
    pkgs.mage
    pkgs.ansible
    pkgs.git-filter-repo
    # pkgs.mariadb-client
    pkgs.cachix
    pkgs.helm-docs
    pkgs.k9s
    pkgs.mkvtoolnix-cli
    pkgs.protobuf
    pkgs.coreutils
    pkgs.k6
    pkgs.regclient
    # pkgs.poetry
    (pkgs.poetry.withPlugins (ps: with ps; [ poetry-plugin-shell ]))

    pkgs.pnpm
    pkgs.git-lfs
    pkgs.azure-cli
    pkgs.gh

    stable-pkgs.terraform
    stable-pkgs.awscli2
    stable-pkgs.tokei
    stable-pkgs.hurl
  ];
}
