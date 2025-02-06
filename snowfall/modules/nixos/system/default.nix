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

    timezone = mkOption {
      default = "America/Los_Angeles";
      type = nullOr str;
    };
  };

  config = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
    networking.hostName = cfg.hostname;
    networking.hostId = cfg.id;

    time.timeZone = cfg.timezone;
  };
}
