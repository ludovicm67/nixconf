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

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, base16-shell, fenix, self }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        ludovic = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
            {
              home = {
                homeDirectory = "/Users/ludovic";
                username = "ludovic";
                stateVersion = "22.11";
              };
            }
          ];

          extraSpecialArgs = { inherit inputs; };
        };
      };

      apps = home-manager.apps;
    };
}
