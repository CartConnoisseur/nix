{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  cxl.desktop.themes."gruvbox" = {
    vim = "gruvbox";

    gtk = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark";
    };

    colors = {
      accent = "cc241d";

      black   = "282828"; brightBlack   = "928374";
      red     = "cc241d"; brightRed     = "fb4934";
      green   = "98971a"; brightGreen   = "b8bb26";
      yellow  = "d79921"; brightYellow  = "fabd2f";
      blue    = "458588"; brightBlue    = "83a598";
      magenta = "b16286"; brightMagenta = "d3869b";
      cyan    = "689d6a"; brightCyan    = "8ec07c";
      white   = "a89984"; brightWhite   = "ebdbb2";

      bg  = "282828";
      bg0 = "282828";
      bg1 = "3c3836";
      bg2 = "504945";
      bg3 = "665c54";
      bg4 = "7c6f64";

      fg  = "ebdbb2";
      fg0 = "fbf1c7";
      fg1 = "ebdbb2";
      fg2 = "d5c4a1";
      fg3 = "bdae93";
      fg4 = "a89984";
    };
  };
}
