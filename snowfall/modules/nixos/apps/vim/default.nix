{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.vim;
in {
  options.${namespace}.apps.vim = with types; {
    enable = mkEnableOption "vim";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
    ];
    
    environment.variables = {
      EDITOR = "${pkgs.vim}/bin/vim";
    };
  };
}
