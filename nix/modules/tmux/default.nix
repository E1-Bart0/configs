{ config, pkgs, ... }:

{
  home.packages = [ pkgs.tmux ];
  
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    prefix = "C-s";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    escapeTime = 10;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      better-mouse-mode
      sensible
      yank
      continuum
      resurrect
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-powerline true
          set -g @dracula-show-flags true
          set -g @dracula-refresh-rate 10
          set -g @dracula-show-left-sep 
          set -g @dracula-show-right-sep 
          set -g @dracula-show-left-icon window

          set -g @dracula-time-format "%R"
          set -g @dracula-plugins "git time cpu-usage ram-usage battery"
          set -g @dracula-time-colors "white dark_gray"
          set -g @dracula-cpu-usage-label "CPU"
          set -g @dracula-cpu-display-load false
          set -g @dracula-cpu-usage-colors "white dark_gray"
          set -g @dracula-ram-usage-label "RAM"
          set -g @dracula-ram-usage-colors "white dark_gray"
          set -g @dracula-battery-label "🔋 "
          set -g @dracula-battery-colors "white dark_gray"

          set -g @dracula-show-empty-plugins false
          set -g status-position top
        '';
      }
    ];

    extraConfig = ''
      bind C-l send-keys 'C-l'
      
      set -g default-command ${pkgs.zsh}/bin/zsh
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-window-option -g mode-keys vi
      set -as terminal-features ",*:hyperlinks"
    '';
  };
}