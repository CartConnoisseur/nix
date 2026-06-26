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

    programs.ssh = {
      enable = true;

      #TODO: set up host block for copenhagen to enable forwarding
      settings = {
        "Host *" = { # old default config
          ForwardAgent = false;
          AddKeysToAgent = false;

          Compression = false;

          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;

          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";

          ControlMaster = false;
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = false;
        };
      };

      enableDefaultConfig = false;
    };

    services.gpg-agent = {
      enableSshSupport = true;
      sshKeys = [ "1DC50342548C9CAACDD88211FF51697C3622D88A" ];
    };
  };
}
