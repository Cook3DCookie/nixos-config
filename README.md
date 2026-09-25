# NixOS Configuration with Home Manager and Flakes

#### to do:

- improve hyprland and waybar config/move to river?
- agenix (or alternatives)
- improve nixvim config (modularize/dendritic?)
- power management?

### command for rebuilding:
on nixos:  
`sudo nixos-rebuild switch --flake ~/nix-config#lukas-nixos`  

on macos:  
`sudo darwin-rebuild switch --flake ~/nix-config#lukas-macos`
