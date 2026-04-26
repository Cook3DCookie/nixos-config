{ config, pkgs, inputs, unstable, ... }: 

{
  home.username = "lukas";
  home.homeDirectory = "/Users/lukas";

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

    #includes = [
      #{
        #condition = "gitdir:~/Documents/university/**"; # change when needed
	#path = "/Users/lukas/nix-config/.gitconfig-university";
	# -------- probably not needed anymore: --------
	#contents = {
	  #user = {
	    #name = "name";
	    #email = "email";
	  #};
	  # optionally gitlab specific settings. needed?
	  # url."git@gitlab.university.ed:".insteadOf = "https://gitlab.university.edu/";
	#};
      #}
    #];
  };

  programs.ssh = { # needed?
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        user = "git";
	identityFile = "~/.ssh/id_ed25519";
      };
      "gitlab.com" = {
        user = "git";
	identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    #curl
    htop
    tree
    #tailscale
    ollama
    #nerd-fonts.fira-code
    #tmux
    tldr
    wget
    #pyton312
    #scrcpy
    #uv
    #ffmpeg
    #micromamba or conda if needed; clean up first, check what is there (miniforge3, envs)
    marp-cli
    #fzf
    #ripgrep
    #gradle
    #imagemagick
    #tesseract
    #gnupg
  ] ++ (with unstable; [
    #ladybird
  ]);

  #fonts.fontconfig.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  imports = [
    #../modules/ghostty.nix
    ../../modules/nixvim.nix
    ../../modules/zsh.nix
    ../../modules/bash.nix
    ../../modules/fish.nix
    ../../modules/starship.nix
    ../../modules/tmux.nix
  ];

  home.stateVersion = "25.11";
}
# command for switching (in current directory): `home-manager switch --flake .#lukas`
