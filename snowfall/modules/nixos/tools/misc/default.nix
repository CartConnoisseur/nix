{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.misc;
in {
  options.${namespace}.tools.misc = with types; {
    enable = mkEnableOption "misc tools";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jq
      killall
      moreutils
      unzip
      wget
    ];
  };
}
