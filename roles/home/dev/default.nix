{ config, pkgs, lib, inputs, ... }:
with lib;

let cfg = config.home.roles.dev; in {
  imports = [
    ./git.nix
    ./vim.nix
    ./vscode.nix
  ];

  options.home.roles.dev = {
    enable = mkEnableOption "dev home role";

    key = mkOption {
      type = types.str;
      description = "git signing key";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      git.enable = true;
      vscode.enable = config.home.roles.desktop.enable;
    };
  };
}
