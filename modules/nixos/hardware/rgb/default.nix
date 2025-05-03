{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.hardware.rgb;
in {
  options.${namespace}.hardware.rgb = with types; {
    enable = mkEnableOption "rgb support";
    headphones = mkEnableOption "headphone support";
  };

  config = mkIf cfg.enable {
    # magic shit :3
    systemd.services."${namespace}.headphone-rgb-disable" = let
      id = "046D:0B1F";
      magic = "11 ff 08 00 0e";
      command = "${pkgs.openrgb}/bin/openrgb -d 'G733 Gaming Headset' --mode off";
      script = pkgs.writeShellScript "headphone-rgb-disable" ''
        ${command}
        ${pkgs.gnugrep}/bin/grep --line-buffered -F '${magic}' /sys/kernel/debug/hid/*:${id}.*/events | while read; do ${command}; done
      '';
    in {
      enable = cfg.headphones;
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = script;
    };

    services = {
      hardware.openrgb.enable = true;
      udev.enable = true;
    };
  };
}
