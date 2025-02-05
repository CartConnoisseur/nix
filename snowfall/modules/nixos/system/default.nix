{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.system;
in {
  options.${namespace}.system = with types; {
    hostname = mkOption {
      type = strMatching "^$|^[[:alnum:]]([[:alnum:]_-]{0,61}[[:alnum:]])?$";
    };

    id = mkOption {
      default = null;
      type = nullOr str;
    };

    impermanent = mkEnableOption "root impermanence";
  };

  config = {
    networking.hostName = cfg.hostname;
    networking.hostId = cfg.id;

    environment = mkIf cfg.impermanent {
      persistence."/persist/system" = {
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
  };
}
