{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.prismlauncher;
  impermanence = config.${namespace}.impermanence;
in {
  options.${namespace}.apps.prismlauncher = with types; {
    enable = mkEnableOption "prismlauncher";

    extra = {
      rusherhack.enable = mkEnableOption "rusherhack";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      prismlauncher
    ];

    home.persistence.${impermanence.location} = {
      directories = [
        ".local/share/PrismLauncher"
      ] ++ optionals cfg.extra.rusherhack.enable [
        #TODO: migrate to proper a secrets management setup, eg agenix/sops-nix
        ".rusherhack"
      ];
    };

    home.file = {
      "Links/PrismLauncher Instances".source = config.lib.file.mkOutOfStoreSymlink (
        "${config.home.homeDirectory}/.local/share/PrismLauncher/instances"
      );
    };
  };
}
