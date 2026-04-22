{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:RGB"
      set-option -g default-command "${pkgs.fish}/bin/fish -l"
      set -s extended-keys on
      set -s extended-keys-format csi-u
      set -as terminal-features 'xterm-ghostty:extkeys'
    '';
  };
}
