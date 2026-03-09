{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 10;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "tray" "clock" "cpu" "temperature" "memory" "network" ]; #pulseaudio

      "hyprland/workspaces" = {
        format = "{name}";
	on-click = "activate";
      };
      clock = {
        format = " {:%H:%M} ";
	tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      cpu = {
        format = " {usage}% ";
	format-alt = " {load} ";
	interval = 2;
	states = {
	  warning = 70;
	  critical = 90;
	};
      };
      memory = {
        format = " {}% ";
	format-alt = " {used:0.1f}G/{total:0.1f}G ";
	interval = 2;
	states = {
	  warning = 75;
	  critical = 90;
	};
	tooltip-format = ''
	  RAM: {used:0.1f}GB/{total:0.1f}GB
	  Swap: {swapUsed:0.1f}GB/{swapTotal:0.1f}GB
	  Top 3 processes by RAM:
	  {top_processes}
	'';
      };
      temperature = {
        thermal-zone = 0;
	format = " {temperatureC}°C ";
	critical-threshold = 80;
	interval = 2;
      };
      network = {
        format-wifi = "{essid} ({signalStrength}%) {ipaddr}";
	format-ethernet = "{ipaddr} {bandwidthDownBytes} {bandwidthUpBytes}";
	format-disconnect = "disconnected";
	#format-icons = {};
	tooltip-format = "{ifname} - {ipaddr}/{cidr}";
	interval = 2;
      };
      tray = {
        spacing = 8;
	icon-size = 16;
      };
    };

    style = ''
      * {
        font-family: "FiraCode Nerd Font";
	font-size: 13px;
	}

        window#waybar {
	  background-color: rgba(26, 27, 38, 0.5);
	  color: #c0caf5;
	  border-radius: 10px;
	  padding: 0 10px;
	}

	#window {
	  background-color: rgba(255, 255, 255, 0.5);
	}

	#workspaces button {
	  padding: 0 5px;
	  background: transparent;
	  color: #c0caf5;
	}

	#workspaces button.focused {
	  background: rgba(122, 162, 247, 0.5);
	  border-radius: 5px;
	}

	#cpu, #memory, #custom-gpu, #clock, #temperature {
	  padding: 0 8px;
	  margin: 0 2px;
	  background: rgba(55, 59, 70, 0.8);
	  border-radius: 6px;
	}
    '';
  };
}
