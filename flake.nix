{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, self }: {
    homeConfigurations = {
      ludovic = home-manager.lib.homeManagerConfiguration {
        system = "aarch64-darwin";
        homeDirectory = "/Users/ludovic";
        username = "ludovic";
        configuration = {
          imports = [ ./home.nix ];
        };
      };
    };

    apps = home-manager.apps;
  };
}
