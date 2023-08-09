{
  description = "A Home Manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, darwin, home-manager, fenix, self }@inputs: {
    darwinConfigurations."mbp-de-ludovic" = darwin.lib.darwinSystem {
      inherit inputs;
      system = "aarch64-darwin";
      modules = [ home-manager.darwinModules.home-manager ./configuration.nix ];
    };

    darwinConfigurations."MacBook-Pro-de-Ludovic" = darwin.lib.darwinSystem {
      inherit inputs;
      system = "aarch64-darwin";
      modules = [ home-manager.darwinModules.home-manager ./configuration.nix ];
    };
  };
}
