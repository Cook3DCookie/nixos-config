{ pkgs, ... }:

{
  git-hooks.hooks = {
    shellcheck.enable = true;
    nixfmt.enable = true;
    ruff.enable = true;
    mdsh.enable = true;
  };

  languages.python = {
    enable = true;
    version = "3.13";
    libraries =
      with pkgs;
      lib.optionals (builtins.pathExists /etc/NIXOS) [
        zlib
        #stdenv.cc.cc.lib
      ];
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
      #cudaPackages_13.cudatoolkit
    ];

  env.UV_PYTHON_DOWNLOADS = "never";
}
