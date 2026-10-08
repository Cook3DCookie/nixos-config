{ ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.targets = [ "hyprland-session.target" ];
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 10;
      modules-left = [
        "clock"
        "tray"
      ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [
        "disk"
        "cpu"
        "temperature"
        "memory"
        "custom/gpu"
        "network"
      ]; # pulseaudio

      "hyprland/workspaces" = {
        format = "{icon}";
        on-click = "activate";
        format-icons = {
          "1" = "一";
          "2" = "二";
          "3" = "三";
          "4" = "四";
          "5" = "五";
          "6" = "六";
          "7" = "七";
          "8" = "八";
          "9" = "九";
          "10" = "十";
        };
      };
      clock = {
        format = " {:%a, %d %b %H:%M} ";
        tooltip-format = "<tt><big>{calendar}</big></tt>";
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
        tooltip-format = "RAM: {used:0.1f}GB/{total:0.1f}GB\nSwap: {swapUsed:0.1f}GB/{swapTotal:0.1f}GB";
      };
      temperature = {
        hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
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
      "custom/gpu" = {
        exec = "nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,memory.used,memory.total --format=csv,noheader,nounits | awk -F', ' '{printf \" %s°C  %s%%  %.1f/%.1fG\", $1, $2, $3/1024, $4/1024}'";
        interval = 4;
        format = "{}";
        tooltip = false;
      };
      disk = {
        path = "/";
        interval = 30;
        format = " {percentage_used}% ";
        tooltip-format = "{used} / {total} used ({percentage_used}%)";
      };
    };

    style = ''
        * {
          font-family: "FiraCode Nerd Font";
      	  font-size: 13px;
      	}

        window#waybar {
      	  border-radius: 10px;
      	  padding: 0 10px;
      	}

      	#workspaces button {
      	  padding: 0 5px;
      	  background: transparent;
      	  color: #c0caf5; /* change after stylix color found */
      	}

      	#workspaces button.active {
      	  background: rgba(122, 162, 247, 0.5); /* change after stylix color found */
      	  border-radius: 5px;
      	}

      	#cpu, #memory, #custom-gpu, #clock, #temperature, #network, #disk {
      	  padding: 0 8px;
      	  margin: 0 2px;
      	  background: rgba(55, 59, 70, 0.8); /* change after stylix color found */
      	  border-radius: 6px;
      	}
    '';
  };
}
