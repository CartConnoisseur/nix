{ config, ... }:

{
  services.flameshot = {
    settings = let c = config.theme.colors; in {
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
}
