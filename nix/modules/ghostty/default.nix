{ config, pkgs, ... }:

{
  home.packages = [ pkgs.ghostty-bin ];
  
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;
    installVimSyntax = true;
    enableZshIntegration = true;
    settings = {
      theme = "Dracula";
    };
  };
}

