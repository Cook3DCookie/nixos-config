{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url =  "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, ... }@inputs:
    let
      system = "x86_64-linux";
      #pkgs = nixpkgs.legacyPackages.${system};
      #unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
    nixosConfigurations.lukas-nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs;
	#inherit unstable;
	};
      modules = [
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.lukas = {
            imports = [
              ./home/home.nix
              nixvim.homeModules.nixvim
            ];
          };
	  home-manager.extraSpecialArgs = {
	    #inherit unstable;
	    inherit inputs;
	  };
        }
      ];
    };
  };
}
