# NixOS Configuration with Home Manager and Flakes

This repository contains my configuration for my NixOS machine and my Macbook (Pro M1) using nix-darwin.
Both use Home Manager and Flakes.

### Current Config:

|Component|Tool|
|---|---|
|Terminal Emulator|[Ghostty](https://ghostty.org/)|
|Shell|[Fish](https://fishshell.com/)|
|Text Editor|[Nixvim](https://nix-community.github.io/nixvim/)|
|Compositor/Window Manager|[Hyprland](https://hypr.land/)|
|Bar|[Waybar](https://github.com/alexays/waybar)|

[Stylix](https://github.com/nix-community/stylix) is used for applying a color scheme and fonts across my NixOS configuration.

### To Do:

- dendritic?
- agenix (or alternatives)
- power management?
- move to river?

### Commands for Rebuilding:

On NixOS:  
`sudo nixos-rebuild switch --flake ~/nix-config#lukas-nixos`  

On macOS:  
`sudo darwin-rebuild switch --flake ~/nix-config#lukas-macos`
