{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.desktop.components.gtk;
  theme = config.${namespace}.desktop.theme;
in {
  options.${namespace}.desktop.components.gtk = with types; {
    enable = mkEnableOption "gtk";
  };

  config = mkIf cfg.enable {
    gtk = {
      enable = true;

      theme = theme.gtk;

      font = {
        name = "monospace";
        size = 8;
      };
    };
  };
}
