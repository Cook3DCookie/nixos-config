{ pkgs, ... }: 

{
  home.username = "lukas";
  home.homeDirectory = "/home/lukas";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
    };
    settings.user.name = "Cook3DCookie";
    settings.user.email = "147427534+Cook3DCookie@users.noreply.github.com";

    #extraConfig = {
      #"includeIf.\"gitdir:~/university/\".path" = "~/.gitconfig-university"; # change when needed
    #};
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
	identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  home.packages = with pkgs; [
    curl
    htop
    tree
    firefox
    google-chrome
    ghostty
    discord
    spotify
    obsidian
    tailscale
    pavucontrol
    ollama
    nerd-fonts.fira-code
  ];

  fonts.fontconfig.enable = true;

  imports = [
    #./modules
    ./modules/hyprland.nix
    ./modules/ghostty.nix
    ./modules/waybar.nix
    ./modules/nixvim.nix
  ];

  home.stateVersion = "25.11";
}
