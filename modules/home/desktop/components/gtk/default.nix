{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.desktop.components.gtk;
in {
  options.${namespace}.desktop.components.gtk = with types; {
    enable = mkEnableOption "gtk";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;

      #TODO: dynamic theming
      theme = {
        package = pkgs.gruvbox-gtk-theme;
        name = "Gruvbox-Dark";
      };

      font = {
        name = "monospace";
        size = 8;
      };
    };
  };
}
