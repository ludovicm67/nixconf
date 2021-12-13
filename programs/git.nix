{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Ludovic Muller";
    userEmail = "ludovicmuller1@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
    };
    signing = {
      gpgPath = "/usr/local/bin/gpg";
      key = "6DE289168B2B031A";
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
      "*.swp"
      ".venv"
      ".tern-port"
      ".pyre"
      ".mypy_cache"
      ".envrc"
      ".direnv/"
    ];
  };
}
