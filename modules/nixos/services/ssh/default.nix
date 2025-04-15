{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.ssh;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.ssh = with types; {
    enable = mkEnableOption "ssh server";

    port = mkOption {
      type = types.port;
      default = 22;
      description = "ssh server port";
    };
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ cfg.port ];
      
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
