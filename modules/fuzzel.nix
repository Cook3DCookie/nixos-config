{ ... }:

{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        lines = 10;
        auto-select = true;
      };
      border = {
        width = 1;
        radius = 0;
      };
    };
  };
}
