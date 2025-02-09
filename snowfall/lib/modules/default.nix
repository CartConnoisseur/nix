{ lib, namespace }:

let
  mkSimpleModule = category: name: { packages ? null, persist ? [] }: (
    { options, config, lib, pkgs, ... }:

    with lib; with lib.${namespace}; let 
      cfg = config.${namespace}.${category}.${name};
      impermanence = config.${namespace}.impermanence;
    in {
      options.${namespace}.${category}.${name} = with types; {
        enable = mkEnableOption "${name}";
      };

      config = mkIf cfg.enable {
        home.packages = if (packages != null) then packages else [ pkgs.${name} ];

        home.persistence.${impermanence.location} = {
          directories = persist;
        };
      };
    }
  );
in {
  mkSimpleApp = name: args@{ ... }: mkSimpleModule "apps" name args;
  mkSimpleTool = name: args@{ ... }: mkSimpleModule "tools" name args;
}
