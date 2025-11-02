{
  description = "Vadim's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs @ { self, nix-darwin, nixpkgs, nix-homebrew, home-manager, flake-utils, ... }: let
    forAllSystems = flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
      };
    });
    
    # Import centralized user configuration
    userConfig = import ./modules/user/default.nix;

    configuration = { pkgs, config, ... }: {
      # Central user configuration
      users.users.${userConfig.username} = {
        home = userConfig.homeDirectory;
        name = userConfig.username;
        description = userConfig.description;
      };
      system.primaryUser = userConfig.username;
      
      nixpkgs.config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };

      # System-level packages (not user-specific)
      environment.systemPackages = [
        pkgs.go
        pkgs.grpcurl
        pkgs.home-manager
        pkgs.htop
        pkgs.jsonnet
        pkgs.kubectl
        pkgs.mkalias
        pkgs.neovim
        pkgs.nodejs_24
        pkgs.obsidian
        pkgs.poetry
        pkgs.postman
        pkgs.pyenv
        pkgs.ripgrep
        pkgs.telegram-desktop
        pkgs.terraform
        pkgs.vscode
      ];

      homebrew = {
        enable = true;
        brews = [
          "clang-format"
        ];
        casks = [
          "macfuse"
        ];
        masApps = {
          # "Bitwarden" = 1352778147;
          # "CopyClip" = 595191960;
        };
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      # Fonts
      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];

      # To Create an alias for searching
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      # System Default options
      system.defaults = {
        finder.AppleShowAllExtensions = true;
        controlcenter.BatteryShowPercentage = true;
        dock.autohide = true;
        dock.persistent-apps = [
          "/System/Applications/Launchpad.app"
          "${pkgs.ghostty-bin}/Applications/Ghostty.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "/Applications/Zen.app"
        ];
        finder.FXPreferredViewStyle = "clmv";
        screensaver.askForPasswordDelay = 10;
      };
      system.keyboard = {
        enableKeyMapping = true;
        remapCapsLockToEscape = true;
      };
      # Touch ID
      security.pam.services.sudo_local.touchIdAuth = true;
      # Touch ID in tmux
      environment = {
        etc."pam.d/sudo_local".text = ''
          # Managed by Nix Darwin
          auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
          auth       sufficient     pam_tid.so
        '';
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;
      # The platform the configuration will be used on.
    };
    darwinSystem = system: nix-darwin.lib.darwinSystem {
      inherit system;
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = system == "aarch64-darwin";
            user = userConfig.username;
            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${userConfig.username} = { config, ... }: {
            imports = [./home.nix];
            home.username = userConfig.username;
            home.homeDirectory = userConfig.homeDirectory;
          };
        }
      ];
    };
  in (forAllSystems // {
    darwinConfigurations = {
      "MacBook-Pro" = darwinSystem "aarch64-darwin";
      "Vadims-MacBook-Pro" = darwinSystem "x86_64-darwin";
    };
  });
}

