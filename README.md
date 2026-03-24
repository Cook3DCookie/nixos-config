# NixOS Configuration with Home Manager and Flakes

#### to do:

- improve hyprland and waybar config
- agenix (or alternatives)
- improve nixvim config (modularize!)
- browser: zen or ladybird if time allows
- power management?

### command for rebuilding:
on nixos:
`sudo nixos-rebuild switch --flake ~/nix-config#lukas-nixos`
on macos:
`home-manager switch --flake ~/nix-config#lukas`
