{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.rebuild;
in {
  options.${namespace}.tools.rebuild = with types; {
    enable = mkEnableOption "rebuild scripts";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "rb" "sudo nixos-rebuild switch --flake /etc/nixos")
      (writeShellScriptBin "rbf" "sudo nixos-rebuild switch --flake path:/etc/nixos")
    ];
  };
}
