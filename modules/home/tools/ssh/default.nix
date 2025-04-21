{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.ssh;
  impermanence = config.${namespace}.impermanence;
in {
  options.${namespace}.tools.ssh = with types; {
    enable = mkEnableOption "ssh";
  };

  config = mkIf cfg.enable {
    home.persistence.${impermanence.secure.location} = {
      directories = [
        ".ssh"
      ];
    };

    programs.ssh.enable = true;

    services.gpg-agent = {
      enableSshSupport = true;
      sshKeys = [ "1DC50342548C9CAACDD88211FF51697C3622D88A" ];
    };
  };
}
