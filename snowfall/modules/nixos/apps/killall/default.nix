{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.killall;
in {
  options.${namespace}.apps.killall = with types; {
    enable = mkEnableOption "killall";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      killall
    ];
  };
}
