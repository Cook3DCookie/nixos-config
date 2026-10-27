{ pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    keyMode = "vi";

    mouse = true;
    prefix = "C-space";
    baseIndex = 1;
    historyLimit = 10000;
    escapeTime = 0;
    focusEvents = true;
    aggressiveResize = true;

    plugins = with pkgs.tmuxPlugins; [
      resurrect # configuration needed for both
      continuum
    ];
    extraConfig = lib.mkMerge [
      ''
                set-option -ga terminal-overrides ",xterm-256color:RGB"
                set -as terminal-features 'xterm-ghostty:extkeys'

                set -s extended-keys on
                set -s extended-keys-format csi-u

                unbind C-b
                bind C-space send-prefix

                set -g pane-base-index 1
                set -g renumber-windows on

                set -g @continuum-save-interval '10'
                set -g @continuum-restore 'on'
        	set -g @resurrect-capture-pane-contents 'on'
        	set -g @resurrect-processes
      ''
      (lib.mkIf pkgs.stdenv.isDarwin ''
        set-option -g default-command "${pkgs.pam-reattach}/bin/reattach-to-session-namespace -- ${pkgs.fish}/bin/fish -l"
      '')
    ];
  };
}
