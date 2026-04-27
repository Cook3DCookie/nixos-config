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
      set -g escape-time 0
      set-option -g default-command "${pkgs.pam-reattach}/bin/reattach-to-session-namespace -- ${pkgs.fish}/bin/fish -l"

      set -s extended-keys on
      set -s extended-keys-format csi-u
      set -as terminal-features 'xterm-ghostty:extkeys'

      set -g @continuum-save-interval '10'
      set -g @continuum-restore 'on'
    '';
  };
}
