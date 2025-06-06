{ config, pkgs, ... }:

{
  imports = [
    ./modules/shell/default.nix
    ./modules/tmux/default.nix
    ./modules/git/default.nix
  ];

  home.username = "starova1";
  home.homeDirectory = "/Users/starova1";
  home.stateVersion = "24.05";

  home.packages = [
    # Development tools that should be system-wide
  ];

  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
