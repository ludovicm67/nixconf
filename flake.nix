{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16-shell = {
      url = "github:chriskempson/base16-shell";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, base16-shell, self }@inputs: {
    homeConfigurations = {
      ludovic = home-manager.lib.homeManagerConfiguration {
        system = "aarch64-darwin";
        homeDirectory = "/Users/ludovic";
        username = "ludovic";
        configuration = { imports = [ ./home.nix ]; };

        extraSpecialArgs = { inherit inputs; };
      };
    };

    apps = home-manager.apps;
  };
}
