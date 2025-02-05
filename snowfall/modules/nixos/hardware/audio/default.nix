{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.hardware.audio;
in {
  options.${namespace}.hardware.audio = with types; {
    enable = mkEnableOption "audio support";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pulseaudio
    ];

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;

      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      #jack.enable = true;
    };
  };
}
