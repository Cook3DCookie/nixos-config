{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url =  "github:nix-community/nixvim/nixos-25.11";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs: {

    nixosConfigurations.lukas-nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x84_64-linux";
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
        }
      ];
    };
  };
}
