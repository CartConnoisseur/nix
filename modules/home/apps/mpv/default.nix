{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.mpv;
in {
  options.${namespace}.apps.mpv = with types; {
    enable = mkEnableOption "mpv";
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      
      config = {
        screenshot-format = "png";
        screenshot-template = "~/Pictures/Screenshots/mpv/%F/%P";

        sub-auto = "fuzzy";
      };

      profiles = {
        ja = {
          profile-restore = "copy";

          sub-font-size = 54;
          sub-bold = true;

          sub-border-style = "outline-and-shadow";
          sub-outline-size = 1.2;
          sub-shadow-offset = 0.8;

          sub-margin-x = 60;
          sub-margin-y = 46;
        };
      };
    };
  };
}
