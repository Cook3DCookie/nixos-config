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

      # >>> conda initialize >>>
      # !! Contents within this block are managed by 'conda init' !!
      __conda_setup="$('/Users/lukas/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
      if [ $? -eq 0 ]; then
          eval "$__conda_setup"
      else
          if [ -f "/Users/lukas/miniforge3/etc/profile.d/conda.sh" ]; then
            . "/Users/lukas/miniforge3/etc/profile.d/conda.sh"
          else
            export PATH="/Users/lukas/miniforge3/bin:$PATH"
          fi
      fi
      unset __conda_setup

      if [ -f "/Users/lukas/miniforge3/etc/profile.d/mamba.sh" ]; then
          . "/Users/lukas/miniforge3/etc/profile.d/mamba.sh"
      fi
      # <<< conda initialize <<<

      exec fish

    '';

    shellAliases = {
      #
    };
  };
}
