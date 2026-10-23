{ pkgs, ... }:

{
  # https://devenv.sh/git-hooks/
  git-hooks.hooks = {
    shellcheck.enable = true;
    nixfmt.enable = true;
    ruff.enable = true;
  };
  # See full reference at https://devenv.sh/reference/options/

  languages.python = {
    enable = true;
    version = "3.12";
    uv = {
      enable = true;
      sync.enable = true;
    };
    venv.enable = true;
  };

  tasks."devenv:python:uv:init" = {
    before = [ "devenv:python:uv" ];
    exec = ''
      if [ ! -f pyproject.toml ]; then
        uv init
      fi
    '';
  };

  packages =
    with pkgs;
    [
      git
    ]
    ++ lib.optionals (builtins.pathExists /etc/NIXOS) [
      #stdenv.cc.cc.lib
      #zlib
      #cudaPackages_13.cudatoolkit
    ];

  env.UV_PYTHON_DOWNLOADS = "never";
}
