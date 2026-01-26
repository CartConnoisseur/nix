{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.minecraft.tower;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.minecraft.tower = with types; {
    enable = mkEnableOption "tower smp minecraft server";

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

    voicechat = {
      port = mkOption {
        type = types.port;
        default = 24454;
        description = "voice chat port";
      };

      force = mkOption {
        type = types.bool;
        default = false;
        description = "require players to have simple voice chat installed";
      };
    };
  };

  config = mkIf cfg.enable {
    cxl.services.minecraft.enable = true;

    environment.persistence.${impermanence.location} = {
      directories = [
        "/srv/minecraft/tower"
      ];
    };

    networking.firewall.allowedUDPPorts = [ cfg.voicechat.port ];

    services.minecraft-servers.servers.tower = {
      enable = true;
      openFirewall = true;
      autoStart = cfg.start;

      package = pkgs.fabricServers.fabric-1_21_11;

      operators = {
        "trimet" = "5321640f-e00d-4118-a6cc-47094f19d084";
      };

      serverProperties = {
        enforce-secure-profile = false;

        white-list = true;
        enforce-whitelist = true;

        gamemode = "survival";
        difficulty = "hard";
        level-seed = "2048000367064948194";
        spawn-protection = 0;

        max-players = 69;
        motd = "the \\u00a79tower\\u00a7r must grow";

        server-port = cfg.port;
        query-port = cfg.port;
      };

      symlinks = {
        "mods" = pkgs.linkFarmFromDrvs "mods" (builtins.attrValues {
          fabric = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/L34yYPTD/fabric-api-0.141.2%2B1.21.11.jar";
            sha256 = "sha256-bB0MT90tgrVgcxiOTK0ogsgODtkifKNzRppCDRz2qXQ=";
          };
          noChatReports = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/rhykGstm/NoChatReports-FABRIC-1.21.11-v2.18.0.jar";
            sha256 = "sha256-FIAjmJ8BT98BLlDYpDp1zErTkZn4mBT1yMo43N7+ELg=";
          };
          chunky = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/fALzjamp/versions/1CpEkmcD/Chunky-Fabric-1.4.55.jar";
            sha256 = "sha256-M8vZvODjNmhRxLWYYQQzNOt8GJIkjx7xFAO77bR2vRU=";
          };
          spark = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/l6YH9Als/versions/1CB3cS0m/spark-1.10.156-fabric.jar";
            sha256 = "sha256-Nu0Tj/3iovH8sy7LzH+iG+rxYR4APRnjrUCVSHPlcvo=";
          };

          #TODO: distributing this as a compiled binary... sucks
          towersmp = pkgs.runCommandLocal "towersmp.jar" {} ''
            cp ${./towersmp-1.0.0.jar} $out
          '';
          voicechat = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/9eGKb6K1/versions/1OVXKX2W/voicechat-fabric-1.21.11-2.6.11.jar";
            sha256 = "sha256-G1/hX+4GVerQMnYrlaNdB8u+Df0hwl7gtSR6ydG5NTs=";
          };

          lithium = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/gl30uZvp/lithium-fabric-0.21.2%2Bmc1.21.11.jar";
            sha256 = "sha256-MQZjnHPuI/RL++Xl56gVTf460P1ISR5KhXZ1mO17Bzk=";
          };
          ferrite = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/uXXizFIs/versions/eRLwt73x/ferritecore-8.0.3-fabric.jar";
            sha256 = "sha256-yG6rrNvwY5ibLKgSyOk/VWuP7/HJ38B8rvodkKXHvzU=";
          };
          krypton = pkgs.fetchurl {
            url = "https://cdn.modrinth.com/data/fQEb0iXm/versions/O9LmWYR7/krypton-0.2.10.jar";
            sha256 = "sha256-lCkdVpCgztf+fafzgP29y+A82sitQiegN4Zrp0Ve/4s=";
          };
        });

        "config/voicechat/voicechat-server.properties" = pkgs.writeText "voicechat-server.properties" ''
          port=${toString cfg.voicechat.port}
          force_voice_chat=${boolToString cfg.voicechat.force}
        '';
      };
    };
  };
}
