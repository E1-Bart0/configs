{ config, pkgs, ... }:

{
  home.packages = [ 
    pkgs.tmux
    pkgs.reattach-to-user-namespace  # Add this for macOS clipboard
  ];
  
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 100000;
    prefix = "C-s";
    mouse = true;
    shell = "${pkgs.zsh}/bin/zsh";
    keyMode = "vi";
    escapeTime = 10;

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      continuum
      extrakto
      resurrect
      sensible
      vim-tmux-navigator
      {
              plugin = yank;
              extraConfig = ''
                # Use system clipboard
                set -g @yank_selection_mouse 'clipboard'
                set -g @yank_action 'copy-pipe-and-cancel'
              '';
      }
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

      # Clipboard settings for macOS
      set -g default-command "reattach-to-user-namespace -l ${pkgs.zsh}/bin/zsh"
      set -g set-clipboard on
      
      # Better paste handling
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      
      # Allow passthrough for clipboard
      set -g allow-passthrough on
      
      set -g default-command ${pkgs.zsh}/bin/zsh
      set -g default-terminal "screen-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-window-option -g mode-keys vi
      set -as terminal-features ",*:hyperlinks"
    '';
  };
}
