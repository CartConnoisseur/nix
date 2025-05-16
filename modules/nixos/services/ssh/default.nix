{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.ssh;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.ssh = with types; {
    enable = mkEnableOption "ssh server";

    ports = mkOption {
      type = listOf port;
      default = [ 22 ];
      description = "ssh server ports";
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = cfg.ports;
      
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
