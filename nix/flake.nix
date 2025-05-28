{
  description = "Vadim's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    nix-homebrew,
    home-manager,
  }: let
    configuration = {
      pkgs,
      config,
      ...
    }: {
      # Allow unfree licensee
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.alacritty
        pkgs.go
        pkgs.grpcurl
        pkgs.home-manager
        pkgs.htop
        pkgs.kubectl
        pkgs.mkalias
        pkgs.neovim
        pkgs.nodejs_23
        pkgs.obsidian
        pkgs.poetry
        pkgs.postman
        pkgs.pyenv
        pkgs.ripgrep
        pkgs.terraform
        pkgs.vscode
        pkgs.wireshark
      ];

      homebrew = {
        enable = true;
        brews = [
          "clang-format"
        ];
        casks = [
          "macfuse"
          # "zen-browser"
        ];
        masApps = {
          "Bitwarden" = 1352778147;
          "CopyClip" = 595191960;
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
          "${pkgs.alacritty}/Applications/Alacritty.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "/Applications/Zen Browser.app"
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
      # nixpkgs.hostPlatform = "aarch64-darwin";
      # system.primaryUser = "starova1";
    };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#yandex

    # Yandex's MacBook Pro 16
    darwinConfigurations."MacBook-Pro" = nix-darwin.lib.darwinSystem {
      # The platform the configuration will be used on.
      system = "aarch64-darwin";
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "starova1";

            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          users.users.starova1.home = "/Users/starova1";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.starova1 = import ./home.nix;
        }
      ];
    };

    # Epam's MacBook Pro 13
    darwinConfigurations."Vadims-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # User owning the Homebrew prefix
            user = "starova1";

            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          users.users.starova1.home = "/Users/starova1";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.starova1 = import ./home.nix;
        }
      ];
    };
  };
}

