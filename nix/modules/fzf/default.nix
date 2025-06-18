{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    fzf
  ];

  programs.fzf = {
    enable = true;
    package = pkgs.fzf;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
  };
}

