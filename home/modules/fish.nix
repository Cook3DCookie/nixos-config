{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
    #starship init fish | source
    '';
  };
  #programs.starship.enable = true;
}
