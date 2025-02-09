{ options, config, lib, pkgs, namespace, ... }:

#NOTE: mkSimpleApp doesnt work for obsidian
# Best guess is that the unfree predicate doesnt apply to /lib
with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.obsidian;
  impermanence = config.${namespace}.impermanence;
in {
  options.${namespace}.apps.obsidian = with types; {
    enable = mkEnableOption "obsidian";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      obsidian
    ];

    home.persistence.${impermanence.location} = {
      directories = [
        ".config/Obsidian"
      ];
    };
  };
}
