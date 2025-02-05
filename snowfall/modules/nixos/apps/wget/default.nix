{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.wget;
in {
  options.${namespace}.apps.wget = with types; {
    enable = mkEnableOption "wget";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wget
    ];
  };
}
