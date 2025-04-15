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

    #TODO: multi-user support
    home = {
      enable = mkEnableOption "home impermanence";

      location = mkOption {
        type = str;
        default = "/persist/home";
      };

      secure.location = mkOption {
        type = str;
        default = "/persist/secure/home";
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
