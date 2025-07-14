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
    };
  };
}
