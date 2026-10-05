{
  description = "System config for my NixOS machine and Macbook with nix-darwin and Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-26.05-darwin";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    nixvim.url =  "github:nix-community/nixvim";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = { url = "path:/home/lukas/pictures/wallpapers"; };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-darwin, ... }@inputs:
    let
      system = "x86_64-linux";
      darwinSystem = "aarch64-darwin";

      unstable = nixpkgs-unstable.legacyPackages.${system};
      unstable-darwin = nixpkgs-unstable.legacyPackages.${darwinSystem};

      mkHomeManager = { extraSpecialArgs, homeFile }: {
	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;
	home-manager.users.lukas = {
	  imports = [
	    homeFile
	    inputs.nixvim.homeModules.nixvim
	  ];
	};
	home-manager.extraSpecialArgs = extraSpecialArgs;
      };
    in {
    packages.${system}.socranop = unstable.callPackage ./pkgs/socranop.nix { };

    nixosConfigurations.lukas-nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs self unstable;
	};
      modules = [
	inputs.stylix.nixosModules.stylix
        ./hosts/nixos/configuration.nix
        home-manager.nixosModules.home-manager
        
	(mkHomeManager {
	  extraSpecialArgs = { inherit inputs unstable; };
	  homeFile = ./hosts/nixos/home.nix;
	})
      ];
    };
    darwinConfigurations.lukas-macos = nix-darwin.lib.darwinSystem {
      system = darwinSystem;
      specialArgs = {
        inherit inputs self unstable-darwin;
      };
      modules = [
        ./hosts/macos/darwin-configuration.nix
	home-manager.darwinModules.home-manager

	(mkHomeManager {
	  extraSpecialArgs = { inherit inputs unstable-darwin; };
	  homeFile = ./hosts/macos/home.nix;
	})
      ];
    };
  };
}
