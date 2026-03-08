{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      exec-once = [ "waybar" "[workspace monitor:HDMI-A-1 silent] ghostty" ];
      #exec-once = [ "waybar" "ghostty" ];
      "$mod" = "SUPER";
      bind = [
        "$mod+Shift, Q, exec, hyprctl dispatch exit"
	"$mod, Return, exec, ghostty"
	"$mod, Q, killactive"
	"$mod, F, exec, firefox"
	"$mod, B, exec, google-chrome-stable"
	#"SUPER, D, exec, tofi-run" #add in home.nix
	"$mod+Shift, D, exec, discord"
	"$mod+Shift, S, exec, spotify"
      ];

      monitor = [
        #",preferred,auto,1"
	"HDMI-A-2,1920x1080@60,0x0,1"
        "HDMI-A-1,1920x1080@60,1920x0,1"
      ];

      input = {
        kb_layout = "us";
      };

      env = [
	"NIXOS_OZONE_WL,1"
	"GDK_BACKEND,wayland"
	"QT_QPA_PLATFORM,wayland;xcb"
	"SDL_VIDEODRIVER,wayland"

	"WLR_NO_HARDWARE_CURSORS,1"
	"LIBVA_DRIVER_NAME,nvidia"
	"GMB_BACKEND,nvidia-drm"
	"__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
    };
  };
}
