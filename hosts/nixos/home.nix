{ config, pkgs, inputs, unstable, ... }: 

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
    enableDefaultConfig = false;
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
    google-chrome
    ghostty
    discord
    spotify
    obsidian
    tailscale
    pavucontrol
    ollama
    nerd-fonts.fira-code
    tofi
    #ladybird
    tmux
    fish
    tldr
    unzip
    #walker
    #anyrun
    wl-clipboard
    uwsm
  ] ++ (with unstable; [
    ladybird
    opencode
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ]);

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ-AA";
    size = 24;
  };

  #gtk = {
    #enable = true;
    #cursorTheme = {
      #package = pkgs.vanilla-dmz;
      #name = "Vanilla-DMZ-AA";
    #};
  #};

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  imports = [
    #./modules
    ../../modules/hyprland.nix
    ../../modules/ghostty.nix
    ../../modules/waybar.nix
    ../../modules/nixvim.nix
    ../../modules/bash.nix
    ../../modules/fish.nix
    ../../modules/starship.nix
  ];

  home.stateVersion = "25.11";
}
