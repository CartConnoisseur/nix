{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.playerctl;
in {
  options.${namespace}.apps.playerctl = with types; {
    enable = mkEnableOption "playerctl";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      playerctl
    ];

    services.playerctld.enable = true;
  };
}
