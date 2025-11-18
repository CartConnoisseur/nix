{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.media;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.suites.media = with types; {
    enable = mkEnableOption "media";
  };

  config = mkIf cfg.enable {
    cxl = {
      apps = mkIf desktop.enable {
        feh.enable = true;
        mpv.enable = true;

        cmus.enable = true;
        
        #TODO: re-enable once qt6 version releases
        jellyfin.enable = false;
      };

      tools = {
        ffmpeg.enable = true;
      };
    };
  };
}
