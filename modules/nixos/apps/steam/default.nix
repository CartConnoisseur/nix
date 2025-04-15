{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.steam;
in {
  options.${namespace}.apps.steam = with types; {
    enable = mkEnableOption "steam";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
    ];
    
    programs.steam.enable = true;
  };
}
