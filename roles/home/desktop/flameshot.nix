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
}
