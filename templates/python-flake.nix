{
  description = "template for python development with nix flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin"; # change if needed, needs improvement
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell { # or mkShellNoCC
        packages = [
	  pkgs.python312
	  pkgs.uv # this solution is by no means perfect, and will be improved if time allows
	  #pkgs.direnv # add if needed, but should be in home.nix
	  #pkgs.git # should also be installed
	];

	shellHook = ''
	  # Color codes
	  GREEN='\033[0;32m'
	  BLUE='\033[0;34m'
	  NC='\033[0m' # No Color

	  echo -e "''${BLUE}nix python env''${NC}"

	  # initialize project if not already a uv project
	  if [ ! -f pyproject.toml ]; then
	    uv init
	    uv sync
	  fi

	  # create virtual environment if missing
	  if [ ! -d .venv ]; then
	    uv venv --seed
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
	    echo "--------------------------------------------------------------------------"
	    echo -e "''${BLUE}RUN \`exit\` FOR THIS TO WORK PROPERLY''${NC}"
	    echo "only needed once"
	    echo "--------------------------------------------------------------------------"
	  fi
	  '';
      };
    };
}
