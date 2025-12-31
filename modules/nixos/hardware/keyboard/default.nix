{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.hardware.keyboard;
in {
  options.${namespace}.hardware.keyboard = with types; {
    enable = mkEnableOption "keyboard hardware tweaks";
    k95.enable = mkEnableOption "k95-specific config";
  };

  config = mkIf cfg.enable {
    services.keyd = {
      enable = true;
      
      keyboards."*".settings = {
        main = {
          # preserve shift distinction
          rightshift = "rightshift";

          # swap alt and meta keys
          leftalt = "leftmeta";
          leftmeta = "leftalt";

          rightalt = "rightmeta";
          rightmeta = "rightalt";

          pause = "toggle(revert)";
        };

        revert = {
          # un-swap alt and meta keys
          leftalt = "leftalt";
          leftmeta = "leftmeta";

          rightalt = "rightalt";
          rightmeta = "rightmeta";
        };
      };
    };

    services.k95aux = {
      enable = cfg.k95.enable;
      mapping = {
        "G1" = 0;  "G2" = 0;  "G3" = 0;
        "G4" = 0;  "G5" = 0;  "G6" = 0;

        "G7" = 0;  "G8" = 0;  "G9" = 0;
        "G10" = 0; "G11" = 0; "G12" = 0;

        "G13" = 0; "G14" = 0; "G15" = 0;
        "G16" = 0; "G17" = 0; "G18" = 0;

        "BRIGHTNESS" = 0;
        "SUPER_LOCK" = 0;
        
        "MR" = 0; "M1" = 0; "M2" = 0; "M3" = 0;
      };
    };
  };
}
