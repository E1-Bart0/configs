.PHONY: update
update:
	@nix flake update
	@nix flake update home-manager

.PHONY: update
upgrade:
	@sudo darwin-rebuild switch --flake ~/.config/nix

.PHONY: all
all: update upgrade

