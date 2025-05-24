{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.hardware.keyboard;
in {
  options.${namespace}.hardware.keyboard = with types; {
    enable = mkEnableOption "keyboard hardware tweaks";
    jp.enable = mkEnableOption "japanese ime support";
  };

  config = mkIf cfg.enable {
    services.keyd = {
      enable = true;
      
      keyboards."*".settings = {
        main = {
          # preserve shift distinction
          rightshift = "rightshift";

          # swap alt and meta keys
          leftalt = "leftmeta";
          leftmeta = "leftalt";

          rightalt = "rightmeta";
          rightmeta = "rightalt";
        };
      };
    };

    i18n.inputMethod = mkIf cfg.jp.enable {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    };

    environment.variables = mkIf cfg.jp.enable {
      # Required for fcitx5 support in kitty
      GLFW_IM_MODULE = "ibus";
    };
  };
}
