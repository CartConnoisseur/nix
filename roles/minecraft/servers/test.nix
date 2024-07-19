{ config, pkgs, lib, ... }:
with lib;

let cfg = config.roles.minecraft.servers.test; in {
  options.roles.minecraft.servers.test = {
    enable = mkEnableOption "test server role";

    port = mkOption {
      type = types.port;
      default = 25565;
      description = "server port";
    };

    start = mkOption {
      type = types.bool;
      default = false;
      description = "autostart";
    };
  };

  config = mkIf cfg.enable {
    services.minecraft-servers.servers.test = {
      enable = true;
      openFirewall = true;
      autoStart = cfg.start;

      package = pkgs.fabricServers.fabric-1_21;

      whitelist = {
        "Townscaper" = "57697615-5b5b-4730-bdaf-5f74ff3ab20d";
        "grippysockjail" = "9448c89d-34eb-4e2c-a231-8112eb1a9e4a";
      };

      operators = {
        "Townscaper" = {
          uuid = "57697615-5b5b-4730-bdaf-5f74ff3ab20d";
          level = 4;
          bypassesPlayerLimit = true;
        };
        "grippysockjail" = "9448c89d-34eb-4e2c-a231-8112eb1a9e4a";
      };

      serverProperties = {
        gamemode = 1;
        max-players = 1;
        motd = ":3";
        port = cfg.port;
      };

      symlinks.mods = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
        fabric = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/vMQdA5QJ/fabric-api-0.100.7%2B1.21.jar";
          sha256 = "sha256-grNmYgSekBaTztR1SLbqZCOC6+QNUDLe4hp105qfibA=";
        };
        noChatReports = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/riMhCAII/NoChatReports-FABRIC-1.21-v2.8.0.jar";
          sha256 = "sha256-jskscOeK3ri2dt3mvWLPVmzddwPqBHJ8Ps+VfZ6l9os=";
        };
      });
    };
  };
}





