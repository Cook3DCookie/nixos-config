{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = {
      background-opacity = if pkgs.stdenv.isDarwin then 1.0 else 0.6;
      background = "#000000";
    };
  };
}
