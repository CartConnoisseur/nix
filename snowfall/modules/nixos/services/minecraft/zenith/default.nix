{ options, config, lib, pkgs, namespace, ... }:

#TODO: nix-ify zenithproxy
with lib; with lib.${namespace}; let
  cfg = config.${namespace}.services.minecraft.zenith;
  impermanence = config.${namespace}.system.impermanence;
in {
  options.${namespace}.services.minecraft.zenith = with types; {
    enable = mkEnableOption "zenithproxy server";

    port = mkOption {
      type = types.port;
      default = 25565;
      description = "server port";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];
  };
}
