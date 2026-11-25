{ inputs, pkgs, ... }:

let
  inherit (inputs) nixpkgs nixpkgs-stable fenix;
  inherit (pkgs.stdenv.hostPlatform) system;
  stable-pkgs =
    (import nixpkgs-stable {
      system = pkgs.stdenv.hostPlatform.system;
      config = {
        allowUnfree = true;
      };
    }).pkgs;

in
{
  system.stateVersion = 5;
  ids.gids.nixbld = 30000;
  nixpkgs.config.allowUnfree = true;

  # Workaround: nixpkgs-unstable removed `--toc-depth` from nixos-render-docs,
  # but current nix-darwin still passes it when building the HTML manual, which
  # breaks `darwin-manual-html` / `darwin-help`. Two independent paths build that
  # manual, so both must be disabled until nix-darwin catches up upstream:
  #   1. the top-level system's own HTML manual (man pages are unaffected), and
  #   2. the darwin-uninstaller, which embeds its own full darwin system that
  #      rebuilds the manual with nix-darwin's defaults (ignoring option 1).
  # Remove both lines once nix-darwin passes `--sidebar-depth` instead.
  documentation.doc.enable = false;
  system.tools.darwin-uninstaller.enable = false;
  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      keep-outputs = true;
      keep-derivations = true;
      sandbox = false;
      trusted-users = [
        "@wheel"
        "ludovic"
      ];
      extra-platforms = [
        "aarch64-darwin"
        # "x86_64-darwin"
      ];
    };
  };

  programs.zsh.enable = true;

  users.users.ludovic = {
    home = "/Users/ludovic";
  };
  users.users.ludovic.shell = pkgs.zsh;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ { home.stateVersion = "26.05"; } ];

    users.ludovic =
      { ... }:
      {
        imports = [ ./programs ];
      };
  };

  # nixpkgs.overlays = [
  #   (
  #     final: prev:
  #     let
  #       inherit (prev) config;
  #       x86Pkgs = import nixpkgs {
  #         inherit config;
  #         localSystem = "x86_64-darwin";
  #       };
  #     in
  #     if prev.stdenv.hostPlatform.system == "aarch64-darwin" then
  #       {
  #         inherit (x86Pkgs) nix-index;
  #       }
  #     else
  #       { }
  #   )
  #   fenix.overlays.default
  # ];

  environment.systemPackages = [
    pkgs.nixfmt
    pkgs.htop
    pkgs.doctl
    stable-pkgs.nodejs_24
    pkgs.tmux
    pkgs.kubectl
    pkgs.pandoc
    pkgs.sops
    pkgs.kustomize
    pkgs.fluxcd
    # pkgs.imagemagick6
    pkgs.imagemagick
    pkgs.postgresql_18
    pkgs.kubernetes-helm
    pkgs.yarn
    pkgs.pwgen
    pkgs.pv
    pkgs.jq
    pkgs.uv

    # (pkgs.fenix.complete.withComponents [
    #   "cargo"
    #   "clippy"
    #   "rust-src"
    #   "rustc"
    #   "rustfmt"
    # ])
    pkgs.rustc
    pkgs.cargo
    pkgs.rustfmt
    pkgs.clippy
    pkgs.rustPlatform.rustLibSrc

    pkgs.rust-analyzer
    pkgs.wrk
    pkgs.maven
    pkgs.jdk21
    pkgs.cmake
    pkgs.jsonnet-bundler
    pkgs.go-jsonnet
    pkgs.tree
    (pkgs.python3.withPackages (
      ps: with ps; [
        pip
        numpy
        toolz
      ]
    ))
    pkgs.gst_all_1.gstreamer
    pkgs.ffmpeg_4
    pkgs.dsq

    pkgs.mongodb-tools
    pkgs.redis
    pkgs.dive
    pkgs.krew
    pkgs.aws-iam-authenticator
    pkgs.kubeseal
    pkgs.php84
    pkgs.php84Packages.composer
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
    pkgs.protobuf
    pkgs.coreutils
    pkgs.k6
    pkgs.regclient
    # pkgs.poetry
    (pkgs.poetry.withPlugins (ps: with ps; [ poetry-plugin-shell ]))

    pkgs.pnpm
    pkgs.git-lfs
    # Workaround: on unstable, azure-cli depends on python `fabric`, which is
    # marked broken since `invoke` was bumped to v3
    # (https://github.com/fabric/fabric/issues/2376). Switch back to `pkgs`
    # once azure-cli evaluates again on unstable.
    (stable-pkgs.azure-cli.withExtensions [
      stable-pkgs.azure-cli.extensions.account
      stable-pkgs.azure-cli.extensions.aks-preview
      stable-pkgs.azure-cli.extensions.ssh
    ])
    pkgs.kubelogin
    pkgs.gh
    pkgs.ghostty-bin
    pkgs.talosctl

    # stable-pkgs.dotnet-sdk
    # stable-pkgs.dotnet-aspnetcore

    stable-pkgs.opentofu
    stable-pkgs.awscli2
    stable-pkgs.tokei
    stable-pkgs.hurl
    stable-pkgs.nmap
    stable-pkgs.mkvtoolnix-cli
  ];
}
