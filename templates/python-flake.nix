{
  description = "template for python development with nix flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; # change if needed
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShellNoCC { # mkShellNoCC instead of mkShell as C compilation is usually not needed
        packages = [
	  pkgs.python312
	  pkgs.uv
	  #pkgs.direnv # add if needed, but should be in home.nix
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
	  fi

	  # create virtual environment if missing
	  if [ ! -d .venv ]; then
	    uv venv --seed
	  fi

	  # activate virtual environment
	  echo -e "''${BLUE}activating virtual environment...''${NC}"
	  source .venv/bin/activate
	  echo -e "''${BLUE}virtual environment ready with python version $(python --version) - deactivate with \`deactivate\`''${NC}"
	  git add flake.nix
	  echo -e "''${GREEN}flake.nix is being tracked with git''${NC}"

	  if [ ! -f .envrc ]; then
	    echo "use flake" > .envrc

	    # not recommended for security reasons:
	    direnv allow
	    # better cat .envrc and ask for direnv allow
	    echo ".envrc created; dev shell loads automatically upon entering directory"
	    echo "----------------------------------------------------------------------------"
	    echo -e "''${BLUE}RUN \`exit\` FOR THIS TO WORK PROPERLY''${NC}"
	    echo "----------------------------------------------------------------------------"
	  fi
	  '';
      };
    };
}
