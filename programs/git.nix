{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Ludovic Muller";
        email = "ludovicmuller1@gmail.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
    };
    signing = {
      signer = "/usr/local/bin/gpg";
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
