{ pkgs, ... }:

{
  gtk = {
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark";
    };

    font = {
      name = "monospace";
      size = 8;
    };
  };
}
