{ config, pkgs, self, ... }:

{
  environment.systemPackages = with pkgs; [
    #git
    #curl
  ];

  users.users.lukas = {
    home = "/Users/lukas";
    #shell = pkgs.fish;
  };

  #security.pam.enableSudoTouchIdAuth = true;

  system.defaults = {
    #dock.autohide = true;
    #finder.FXPreferredViewStyle = "clmv";
  };

  homebrew = {
    enable = false;
    casks = [
      #
    ];
  };

  #system.configurationRevision = self.rev or self.dirtyRev or null;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  system.stateVersion = 5;
}
