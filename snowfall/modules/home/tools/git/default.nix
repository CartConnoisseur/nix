{ options, config, lib, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.tools.git;
in {
  options.${namespace}.tools.git = with types; {
    enable = mkEnableOption "git";

    name = mkOption {
      type = str;
    };

    email = mkOption {
      type = str;
    };

    key = mkOption {
      type = nullOr str;
    };

    sign = mkOption {
      type = bool;
      default = true;
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;

      userName = cfg.name;
      userEmail = cfg.email;

      signing = {
        key = cfg.key;
        signByDefault = cfg.sign;
      };

      ignores = [
        "*~"
        "*.swp"
      ];  
    };
  };
}

