{ options, config, osConfig, lib, namespace, inputs, host, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.impermanence;
  os = osConfig.${namespace}.system.impermanence.home;
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  options.${namespace}.impermanence = with types; {
    skeleton = mkOption {
      type = bool;
      default = true;
    };

    enable = mkOption { type = uniq bool; };
    location = mkOption { type = uniq str; };
    secure.location = mkOption { type = uniq str; };
  };

  config = {
    ${namespace}.impermanence = {
      inherit (os) enable location secure;
    };

    home.persistence.${cfg.location} = {
      enable = cfg.enable;
      allowOther = true;

      directories = mkIf cfg.skeleton [
        ".local/share/applications"
        ".local/bin"

        "Downloads"
        "Documents"
        "Pictures"
        "Videos"
        "Music"
        "Games"
        "Links"
        "Persist"
      ];
    };

    home.persistence.${cfg.secure.location} = {
      enable = cfg.enable;
      allowOther = false;
    };
  };
}
