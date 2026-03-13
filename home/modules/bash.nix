{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
    };
    initExtra = ''
    if [ -n "$VIRTUAL_ENV" ]; then
      PS1="($(basename $VIRTUAL_ENV)) $PS1"
    fi
    '';
  };
}
