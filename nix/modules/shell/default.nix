{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bash-completion
    bashInteractive
    oh-my-zsh
    zsh
    zsh-completions
    zsh-powerlevel10k
  ];

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
      fpath+="$HOME/.zfunc"
      compinit
    '';

    shellAliases = {
      ll = "ls -la";
      nv = "nvim";
    };

    history.size = 10000;

    sessionVariables = {
      PIPENV_IN_PROJECT=true;
      POETRY_VIRTUALENVS_IN_PROJECT=true;
      PYENV_ROOT="$HOME/.pyenv";
      PYTHON_AUTO_VRUN=true;
      PYTHON_VENV_NAME=".venv";
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
        "z"
      ];
      extraConfig = ''
        zstyle ':completion:*' completer _expand _complete _ignored _approximate _expand_alias
        zstyle ':autocomplete:*' default-context curcontext 
        zstyle ':autocomplete:*' min-input 0
        zstyle ':completion:*:make:*:targets' call-command true
        zstyle ':completion:*:*:make:*' tag-order 'targets'

        setopt HIST_FIND_NO_DUPS

        autoload -Uz compinit
        compinit

        setopt autocd
        setopt globdots
      '';
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./../shell/p10k-config;
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
}