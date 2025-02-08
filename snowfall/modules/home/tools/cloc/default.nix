{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.cloc;
in {
  options.${namespace}.tools.cloc = with types; {
    enable = mkEnableOption "cloc";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cloc
    ];
  };
}
