{
  description = "template for zig development with nix flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #zig-overlay.url = "github:mitchellh/zig-overlay"; # more version flexibility?
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; # change if needed
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
	  pkgs.zig
	  pkgs.zls
	  #pkgs.llvmPackages_17.clang # needed?
	  #pkgs.llvmPackages_17.lld # needed?
	  #pkgs.direnv # add if needed, but should be in home.nix
	];

	hardeningDisable = [ "all" ];

	# TODO:
	shellHook = ''
	  '';
      };
    };
}
