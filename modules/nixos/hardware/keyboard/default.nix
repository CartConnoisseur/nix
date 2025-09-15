{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.hardware.keyboard;
in {
  options.${namespace}.hardware.keyboard = with types; {
    enable = mkEnableOption "keyboard hardware tweaks";
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
  };
}
