{ config, ... }:

{
  services.flameshot = {
    enable = true;

    settings = let c = config.theme.colors; in {
      General = {
        savePath = "Pictures/Screenshots";

        uiColor = "#${c.bg}";
        contrastUiColor = "#${c.accent}";


        filenamePattern = "%F_%T";

        startupLaunch = false;
        saveAfterCopy = true;
      };
    };
  };
}
