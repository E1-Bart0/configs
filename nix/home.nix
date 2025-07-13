{ config, pkgs, ... }:

# Manual https://nix-community.github.io/home-manager/options.xhtml

let
  # Import centralized user configuration
  userConfig = import ./modules/user/default.nix;
in
{
  imports = [
    ./modules/fzf/default.nix
    ./modules/ghostty/default.nix
    ./modules/git/default.nix
    ./modules/shell/default.nix
    ./modules/tmux/default.nix
    ./modules/zoxide/default.nix
  ];

  # Use centralized user configuration
  home.username = userConfig.username;
  home.homeDirectory = userConfig.homeDirectory;
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
