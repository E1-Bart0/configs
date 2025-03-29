{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "starova1";
  home.homeDirectory = "/Users/starova1";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.bash-completion
    pkgs.bashInteractive
    pkgs.oh-my-zsh
    pkgs.tmux
    pkgs.zsh
    pkgs.zsh-completions
    pkgs.zsh-powerlevel10k
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/ycp/bin"
    "$PYENV_ROOT/bin"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    package = pkgs.bashInteractive;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    package = pkgs.zsh;
    initExtra = ''
      eval "$(pyenv init -)"
      fpath+='$HOME/.zfunc'
    '';

    shellAliases = {
      ll = "ls -l";
      nv = "nvim";
      update-nix = "nix flake update; nix flake update home-manager";
      update = "darwin-rebuild switch --flake ~/.config/nix";
      ya = "$HOME/arcadia/ya";
    };

    history.size = 10000;

    sessionVariables = {
      # python
      PIPENV_IN_PROJECT=true;
      POETRY_VIRTUALENVS_IN_PROJECT=true;
      PYENV_ROOT="$HOME/.pyenv";
      PYTHON_AUTO_VRUN=true;
      PYTHON_VENV_NAME=".venv";
      # tmux
      ZSH_TMUX_AUTOSTART=false;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "git"
        "poetry"
        "python"
        "tmux"
        "vi-mode"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./p10k-config;
        file = "p10k.zsh";
      }
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
      {
        name = "zsh-async";
        file = "async.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "mafredri";
          repo = "zsh-async";
          rev = "v1.8.6";
          sha256 = "Js/9vGGAEqcPmQSsumzLfkfwljaFWHJ9sMWOgWDi0NI=";
        };
      }
    ];
  };

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
          # Dracula plugin setup
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
      # Bring back clear screen under tmux prefix
      bind C-l send-keys 'C-l'
      
      # Set ZSH
      set -g default-command ${pkgs.zsh}/bin/zsh
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-window-option -g mode-keys vi
    '';
  };
  
  programs.git = {
    enable = true;
    userName = "Vadim Starovoitov";
    userEmail = "starovoitov.vadik1@gmail.com";
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/starova1/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
