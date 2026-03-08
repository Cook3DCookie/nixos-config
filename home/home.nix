{ pkgs, ... }: 

{
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user.name = "Cook3DCookie";
    settings.user.email = "147427534+Cook3DCookie@users.noreply.github.com";

    #extraConfig = {
      #"includeIf.\"gitdir:~/university/\".path" = "~/.gitconfig-university"; # change when needed
    #};
  };

  home.packages = with pkgs; [
    curl
    htop
    tree
    google-chrome
    ghostty
    discord
    spotify
    obsidian
    tailscale
    pavucontrol
  ];

  imports = [
    #./modules
    ./modules/hyprland.nix
    ./modules/ghostty.nix
    ./modules/waybar.nix
    ./modules/nixvim.nix
  ];

  home.stateVersion = "25.11";
}
