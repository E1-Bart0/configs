
# My configuration

Consists from

- Nix - system management
- Alacritty - terminal (comapre and replace with [Ghostty](https://ghostty.org/))
- Nvim

## Installation guide

1. Install [Nix](https://nixos.org/download/)

```bash
sh <(curl -L https://nixos.org/nix/install)
```

2. Install nix-darwin

```bash
nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.config/nix
```

## How-To Use

### Update
```bash
darwin-rebuild switch --flake ~/.config/nix
```

