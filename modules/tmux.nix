{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      resurrect # configuration needed for both
      continuum
    ];
    extraConfig = ''
      set-option -ga terminal-overrides ",xterm-256color:RGB"
      set -g mouse on

      set -g prefix C-space
      unbind C-b
      bind C-space send-prefix

      set -g base-index 1
      set -g pane-base-index 1
      set -g renumber-windows on
      
      set -g history-limit 10000

      set -s extended-keys on
      set -s extended-keys-format csi-u
      set -as terminal-features 'xterm-ghostty:extkeys'

      set -g @continuum-restore 'on'
    '';
  };
}
