{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.gpg;
  impermanence = config.${namespace}.impermanence;
in {
  options.${namespace}.tools.gpg = with types; {
    enable = mkEnableOption "gpg";
  };

  config = mkIf cfg.enable {
    home.persistence.${impermanence.secure.location} = {
      directories = [
        ".gnupg"
      ];
    };

    programs.gpg.enable = true;
  };
}
