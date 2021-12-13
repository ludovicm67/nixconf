{ pkgs, ... }:

{
  imports = [ ./git.nix ./tmux.nix ./zsh.nix ];

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
  };
}
