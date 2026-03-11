{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;

    settings = {
      animations.enabled = false;
      general = {
        gaps_out = 1;
        gaps_in = 3;
	border_size = 1;
	resize_on_border = true;
	#col = {
	  #active_border = rgba(ffffffaa);
	  #inactive_border = rgba(595959aa);
	#};
      };
      exec-once = [ "[workspace monitor:HDMI-A-1 silent] ghostty" ];
      "$mod" = "SUPER";
      bind = [
        "$mod+Shift, Q, exec, exit"
	"$mod, Return, exec, ghostty"
	"$mod, Q, killactive"
	"$mod, V, togglefloating"
	"$mod, F, exec, firefox"
	"$mod, B, exec, google-chrome-stable"
	"SUPER, D, exec, tofi-run" #add in home.nix
	"$mod+Shift, D, exec, discord"
	"$mod+Shift, S, exec, spotify"
	"$mod, L, exec, Ladybird"

	"$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"

	"$mod, 1, workspace, 1"
	"$mod, 2, workspace, 2"
	"$mod, 3, workspace, 3"
	"$mod, 4, workspace, 4"
	"$mod, 5, workspace, 5"
	"$mod, 6, workspace, 6"
	"$mod, 7, workspace, 7"
	"$mod, 8, workspace, 8"
	"$mod, 9, workspace, 9"
	"$mod, 0, workspace, 10"
	

	"$mod+Shift, 1, movetoworkspace, 1"
	"$mod+Shift, 2, movetoworkspace, 2"
	"$mod+Shift, 3, movetoworkspace, 3"
	"$mod+Shift, 4, movetoworkspace, 4"
	"$mod+Shift, 5, movetoworkspace, 5"
	"$mod+Shift, 6, movetoworkspace, 6"
	"$mod+Shift, 7, movetoworkspace, 7"
	"$mod+Shift, 8, movetoworkspace, 8"
	"$mod+Shift, 9, movetoworkspace, 9"
	"$mod+Shift, 0, movetoworkspace, 10"
      ];

      bindm = [
	"$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
      ];
      

      monitor = [
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
