{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.flameshot;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.apps.flameshot = with types; {
    enable = mkEnableOption "flameshot";
  };

  config = mkIf cfg.enable {
    services.flameshot = {
      enable = true;

      settings = let c = desktop.theme.colors; in {
        General = {
          savePath = "Pictures/Screenshots";
          filenamePattern = "%F_%T";

          saveAfterCopy = true;

          uiColor = "#${c.bg}";
          contrastUiColor = "#${c.accent}";

          startupLaunch = false;
        };
      };
    };

    #TODO: relocate. target.tray required for flameshot
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
  };
}
