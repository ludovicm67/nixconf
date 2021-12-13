{ inputs, ... }:

let inherit (inputs) base16-shell;

in {
  programs.zsh = {
    enable = true;
    shellAliases = {
      k = "kubectl";
      copy = "pbcopy";
      o = "open";
    };
    sessionVariables = { DEFAULT_USER = "ludovic"; };
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "sudo" "tmux" ];
    };
    plugins = [{
      name = "base16-shell";
      src = base16-shell;
    }];
  };
}
