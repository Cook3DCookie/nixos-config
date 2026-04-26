{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if test (uname -m) = x86_64
	echo "⚠️ Running under Rosetta (x86_64). Run 'uname -m' to check"
	echo -ne "\033]0;Rosetta Terminal (x86_64)\007"
      end

      if command -q starship
        starship init fish | source
      end
    '';
  };
}
