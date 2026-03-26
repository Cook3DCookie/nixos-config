{ config, lib, pkgs, inputs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      if [[ $(uname -m) == "x86_64" ]]; then
        echo "⚠️ Running under Rosetta (x86_64). Run 'uname -m' to check"
        echo -ne "\033]0;Rosetta Terminal (x86_64)\007"
      fi

      exec fish
    '';

    shellAliases = {
      #
    };
  };
}
