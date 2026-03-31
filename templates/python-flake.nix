{
  description = "template for python development with nix flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ];
    in {
      devShells = forAllSystems (system:
	let
	  pkgs = import nixpkgs {
	    inherit system;
	    config = { allowUnfree = true; };
	  };
	in {
	  default = pkgs.mkShell { # or mkShellNoCC
	    packages = with pkgs; [
	      python312
	      uv # this solution is by no means perfect, and will be improved if time allows
	      #pkgs.direnv # add if needed, but should be in home.nix
	      #pkgs.git # should also be installed
	    ] ++ pkgs.lib.optionals (builtins.pathExists /etc/NIXOS) [
	      stdenv.cc.cc.lib # needed for numpy, provides libstdc++.so.6
	      zlib
	      cudaPackages_13.cudatoolkit
	    ];

	    shellHook = ''
	    ${pkgs.lib.optionalString (builtins.pathExists /etc/NIXOS) ''
		export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib:${pkgs.cudaPackages_13.cudatoolkit}/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH
	      ''}

	      # Color codes
	      GREEN='\033[0;32m'
	      BLUE='\033[0;34m'
	      NC='\033[0m' # No Color

	      echo -e "''${BLUE}nix python env''${NC}"

	      # initialize project if not already a uv project
	      if [ ! -f pyproject.toml ]; then
		uv init
	      fi

	      # create virtual environment if missing and sync
	      if [ ! -d .venv ]; then
		uv venv --seed
		uv sync
	      fi

	      # activate virtual environment
	      echo -e "''${BLUE}activating virtual environment...''${NC}"
	      source .venv/bin/activate
	      echo -e "''${BLUE}virtual environment ready with python version $(python --version) - deactivate with \`deactivate\`. usually not necessary to do so.''${NC}"
	      git add flake.nix
	      echo -e "''${GREEN}flake.nix is being tracked with git''${NC}"

	      if [ ! -f .envrc ]; then
		echo "use flake" > .envrc

		# not recommended for security reasons:
		direnv allow
		# better cat .envrc and ask for direnv allow
		echo ".envrc created; dev shell loads automatically upon entering directory"
		echo "----------------------------------------------------------------------"
		echo -e "''${BLUE}RUN \`exit\` FOR THIS TO WORK PROPERLY''${NC}"
		echo "only needed once"
		echo "----------------------------------------------------------------------"
	      fi
	      '';
	  };
	}
      );
    };
}
