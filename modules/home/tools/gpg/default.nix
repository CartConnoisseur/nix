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

    #NOTE: required for pinentry-gnome3
    home.packages = with pkgs; [
      gcr
    ];

    programs.gpg.enable = true;

    services.gpg-agent = {
      enable = true;

      pinentry.package = (pkgs.writeShellScriptBin "pinentry-wrapper" ''
        if [[ -v DISPLAY ]]; then
          exec ${pkgs.pinentry-gnome3}/bin/pinentry-gnome3 "$@"
        fi
        
        exec ${pkgs.pinentry-gnome3}/bin/pinentry-tty "$@"
      '');
    };
  };
}
