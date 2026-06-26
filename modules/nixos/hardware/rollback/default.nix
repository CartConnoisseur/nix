{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.hardware.boot.rollback;
in {
  options.${namespace}.hardware.boot.rollback = with types; {
    zfs = {
      enable = mkEnableOption "rollback zfs volumes on boot";

      volumes = let 
        volume = submodule {
          options = {
            pool = mkOption {
              type = str;
            };

            volume = mkOption {
              type = str;
            };

            snapshot = mkOption {
              type = str;
            };
          };
        };
      in mkOption {
        type = listOf (coercedTo str (value: (
          let match = builtins.elemAt (builtins.match "(.+?)\/(.+)@(.+)" value);
          in { pool = match 0; volume = match 1; snapshot = match 2; }
        )) volume);

        default = [];
      };
    };
  };

  config = mkIf cfg.zfs.enable {
    boot.initrd.systemd = {
      enable = true;

      extraBin.zfs = "${pkgs.zfs}/sbin/zfs";

      services = builtins.listToAttrs (builtins.map (value: {
        name = strings.replaceString "/" "-" "${namespace}.boot.rollback-${value.pool}/${value.volume}";
        value = {
          description = "Rollback ZFS dataset ${value.pool}/${value.volume} to ${value.snapshot}";

          requires = [ "zfs-import-${value.pool}.service" ];
          wantedBy = [ "sysroot.mount" ];

          unitConfig.DefaultDependencies = false;

          serviceConfig = {
            Type = "oneshot";
            ExecStart = "/bin/zfs rollback -r ${value.pool}/${value.volume}@${value.snapshot}";
          };
        };
      }) cfg.zfs.volumes);
    };
  };
}
