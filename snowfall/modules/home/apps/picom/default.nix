{ options, config, lib, namespace, ... }:

#TODO: move somewhere else
# most likely will move several things into modules/desktop/components or similar
with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.picom;
in {
  options.${namespace}.apps.picom = with types; {
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
      };
    };
  };
}
