{ config, pkgs, lib, inputs, ... }:
with lib;

let cfg = config.roles.web.stargazers; in {
  options.roles.web.stargazers = {
    enable = mkEnableOption "stargazers webserver";
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 ];
    
    services.nginx = {
      enable = true;
      virtualHosts = {
        "stargazers.xn--6frz82g".root = "/srv/web/stargazers";
      };
    };
  };
}