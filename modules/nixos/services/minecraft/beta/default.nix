{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.minecraft.beta;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.minecraft.beta = with types; {
    enable = mkEnableOption "beta 1.7.3 minecraft server";

    port = mkOption {
      type = types.port;
      default = 25565;
      description = "server port";
    };

    start = mkOption {
      type = types.bool;
      default = true;
      description = "autostart";
    };
  };

  config = mkIf cfg.enable {
    cxl.services.minecraft.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/srv/minecraft/beta"
      ];
    };

    services.minecraft-servers.servers.beta = {
      enable = true;
      openFirewall = true;
      autoStart = cfg.start;

      package = pkgs.cxl."minecraft-server-b1.7.3";
      jvmOpts = "-Dhttp.proxyHost=betacraft.uk -Dhttp.proxyPort=11705 -Xms1024M -Xmx2048M";

      serverProperties = {
        white-list = true;
        max-players = 69;
        server-port = cfg.port;
      };
    };
  };
}
