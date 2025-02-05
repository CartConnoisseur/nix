{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.killall;
in {
  options.${namespace}.apps.jq = with types; {
    enable = mkEnableOption "jq";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jq
    ];
  };
}
