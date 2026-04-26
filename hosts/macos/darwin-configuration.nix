{ config, pkgs, self, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  users.users.lukas = {
    home = "/Users/lukas";
    shell = pkgs.fish;
  };

  system.primaryUser = "lukas";
  programs.fish.enable = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    dock.autohide = true;
    finder.FXPreferredViewStyle = "clmv";
  };

  homebrew.enable = false;

  system.configurationRevision = self.rev or self.dirtyRev or null;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ];

  system.stateVersion = 5;
}
