{ pkgs, ... }:

{
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Ludovic Muller";
      userEmail = "ludovicmuller1@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

  home.packages = [
    pkgs.htop
    pkgs.doctl
  ];
}
