{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      k = "kubectl";
      copy = "pbcopy";
      o = "open";
    };
    sessionVariables = {
      DEFAULT_USER = "ludovic";
    };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [
        "git"
        "sudo"
        "tmux"
      ];
    };
    initContent = ''
      ${builtins.readFile ./zsh-init.zsh}
    '';

    plugins = [
      {
        name = "base16-shell";
        src = pkgs.fetchFromGitHub {
          owner = "chriskempson";
          repo = "base16-shell";
          rev = "ce8e1e5";
          sha256 = "1yj36k64zz65lxh28bb5rb5skwlinixxz6qwkwaf845ajvm45j1q";
        };
      }
    ];
  };
}
