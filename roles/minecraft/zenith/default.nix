{ config, lib, pkgs, ... }:
with lib;

let cfg = config.roles.minecraft.zenith; in {
  options.roles.minecraft.zenith = {
    enable = mkEnableOption "zenith proxy role";

    port = mkOption {
      type = types.port;
      default = 25565;
      description = "server port";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = true;
      description = "open firewall";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}
