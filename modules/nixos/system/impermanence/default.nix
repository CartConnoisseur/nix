{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.system.impermanence;
in {
  options.${namespace}.system.impermanence = with types; {
    enable = mkEnableOption "root impermanence";

    location = mkOption {
      type = str;
      default = "/persist/system";
    };

    home = {
      enable = mkEnableOption "home impermanence";

      # in a completely undocumented and non-overridable change (yes im a little upset),
      # home impermanence moved from the location provided to the location provided + $HOME.
      # forcing me to move all my shit is NOT cool. dont remove user choice for no reason.
      # especially not in a breaking change, and ESPECIALLY not an *UNDOCUMENTED ONE!*

      # anyways, now home is at just /persist while system is in a subdir. because that
      # makes sense. actual persist path = /persist/home/c
      location = mkOption {
        type = str;
        default = "/persist";
      };

      secure.location = mkOption {
        type = str;
        default = "/persist/secure";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.fuse.userAllowOther = true;

    environment.persistence.${cfg.location} = {
      hideMounts = true;

      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        # "/var/lib/bluetooth"
      ];
      
      files = [
        "/etc/machine-id"
      ];
    };
  };
}
