{ config, pkgs, ... }:

# Manual https://nix-community.github.io/home-manager/options.xhtml

{
  imports = [
    ./modules/fzf/default.nix
    ./modules/ghostty/default.nix
    ./modules/git/default.nix
    ./modules/shell/default.nix
    ./modules/tmux/default.nix
  ];

  home.username = "starova1";
  home.homeDirectory = "/Users/starova1";
  home.stateVersion = "25.05";

  home.packages = [
    # Development tools that should be system-wide
  ];

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
