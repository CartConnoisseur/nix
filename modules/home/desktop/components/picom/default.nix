{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.desktop.components.picom;
in {
  options.${namespace}.desktop.components.picom = with types; {
    enable = mkEnableOption "picom";
  };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;

      backend = "glx";
      vSync = true;

      settings = {
        blur = {
          method = "gaussian";
          size = 10;
          deviation  = 2;
        };

        blur-background-exclude = [
          "window_type = 'dock'"
        ];

        corner-radius = 0;
      };
    };
  };
}
