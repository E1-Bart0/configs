.PHONY: update
update:
	@nix flake update
	@nix flake update home-manager

.PHONY: upgrade
upgrade:
	@sudo darwin-rebuild switch --flake ~/.config/nix

.PHONY: home
home:
	@home-manager switch --flake ~/.config/nix

.PHONY: all
all: update upgrade

