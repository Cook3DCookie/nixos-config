{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if command -q starship
        starship init fish | source
      end
    '';
  };
}
