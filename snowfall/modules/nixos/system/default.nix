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
  };

  config = {
    networking.hostName = cfg.hostname;
    networking.hostId = cfg.id;
  };
}