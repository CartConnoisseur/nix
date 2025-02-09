{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.suites.media;
in {
  options.${namespace}.suites.media = with types; {
    enable = mkEnableOption "media";
  };

  config = mkIf cfg.enable {
    cxl = {
      apps = {
        feh.enable = true;
        mpv.enable = true;

        cmus.enable = true;
        
        jellyfin.enable = true;
      };

      tools = {
        ffmpeg.enable = true;
      };
    };
  };
}
