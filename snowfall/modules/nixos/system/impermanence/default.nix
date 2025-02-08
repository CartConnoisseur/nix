{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.system.impermanence;
in {
  options.${namespace}.system.impermanence = with types; {
    enable = mkEnableOption "root impermanence";
  };

  config = mkIf cfg.enable {
    programs.fuse.userAllowOther = true;

    environment.persistence."/persist/system" = {
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
