{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
    };
    initExtra = ''
    eval "$(direnv hook bash)"
    eval "$(starship init bash)"
    '';
  };
  programs.starship.enable = true;
}
