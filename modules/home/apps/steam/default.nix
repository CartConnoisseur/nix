{ options, config, osConfig, lib, pkgs, namespace, ... }:

#NOTE: steam must be installed system-wide.
# This module does nothing unless steam is enabled at the
# system level as well. This is only a separate toggle so
# that not every user gets steam files in their home.
with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.steam;
  oscfg = osConfig.${namespace}.apps.steam;
  impermanence = config.${namespace}.impermanence;
in {
  options.${namespace}.apps.steam = with types; {
    enable = mkEnableOption "steam";
  };

  config = mkIf (cfg.enable && oscfg.enable) {
    home.persistence.${impermanence.location} = {
      directories = [{
        directory = ".local/share/Steam";
      }];
    };

    home.file = {
      "Links/Steam Games".source = config.lib.file.mkOutOfStoreSymlink (
        "${config.home.homeDirectory}/.local/share/Steam/steamapps/common"
      );
    };
  };
}
