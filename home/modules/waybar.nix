{ config, pkkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 15;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "pulseaudio" "network" "cpu" "memory" "clock" "tray" ];

      "hyprland/workspaces" = {
        format = "{name}";
	on-click = "activate";
      };
      clock = {
        format = "{:%H:%M}";
	tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
    };

    style = ''
      * {
        font-family: "FiraCode Nerd Font";
	font-size: 12px;
      }
	#window {
	  background-color: rgba(30, 30, 46, 0.9);
       }
    '';
  };
}
