{ options, config, lib, namespace, pkgs, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.unbound;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.unbound = with types; {
    enable = mkEnableOption "unbound dns server";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 53 ];
    networking.firewall.allowedUDPPorts = [ 53 ];

    services.unbound = {
      enable = true;
      settings = {
        server = {
          logfile = "unbound.log";
          verbosity = 3;

          interface = [ 
            "0.0.0.0"
            "::0"
          ];
          access-control = [
            "10.0.0.0/8 allow"
            "192.168.0.0/16 allow"
            "2001:DB8::/64 allow"
          ];

          do-not-query-localhost = false;

          local-zone = ''"cxl.sh." redirect'';
          local-data = [
            ''"cxl.sh. 30 IN A 192.168.254.11"''
          ];
        };

        forward-zone = [{
          name = ".";
          # sobbing
          # forward-addr = [
          #   "1.1.1.1@853#cloudflare-dns.com"
          #   "1.0.0.1@853#cloudflare-dns.com"
          # ];
          forward-addr = [
            "1.1.1.1"
            "1.0.0.1"
          ];
        }];
      };
    };
  };
}
