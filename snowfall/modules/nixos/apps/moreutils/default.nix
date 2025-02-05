{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.moreutils;
in {
  options.${namespace}.apps.moreutils = with types; {
    enable = mkEnableOption "moreutils";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      moreutils
    ];
  };
}
