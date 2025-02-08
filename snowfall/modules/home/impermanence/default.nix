{ options, config, lib, namespace, inputs, host, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.impermanence;
  hosts = [ "c-pc" ];
in {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  options.${namespace}.impermanence = with types; {
    skeleton = mkOption {
      type = bool;
      default = true;
    };

    location = mkOption {
      type = str;
      default = "/persist/home";
    };

    secure = {
      location = mkOption {
        type = str;
        default = "/persist/secure/home";
      };
    };
  };

  config = {
    home.persistence.${cfg.location} = {
      enable = builtins.elem host hosts;
      allowOther = true;

      directories = mkIf cfg.skeleton [
        "Downloads"
        "Documents"
        "Pictures"
        "Videos"
        "Music"
        "Games"
        "Persist"
      ];
    };

    home.persistence.${cfg.secure.location} = {
      enable = builtins.elem host hosts;
      allowOther = false;
    };
  };
}
