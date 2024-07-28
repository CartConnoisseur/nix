{ pkgs, ... }:

{
  services = {
    libinput = {
      touchpad.naturalScrolling = true;
    };

    keyd = {
      keyboards."*".settings = {
        main = {
          # Swap alt and meta keys.
          # I prefer (physical) alt as my WM modifier key because it
          #   is easier to reach. This can collide with some programs
          #   shortcuts if they inlcude alt. Swapping alt and meta fixes
          #   this by making my WM mod key (software) meta, freeing up alt.

          leftalt = "leftmeta";
          leftmeta = "leftalt";

          rightalt = "rightmeta";
          rightmeta = "rightalt";
        };
      };
    };
  };

  i18n.inputMethod = {
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc ];
  };

  environment.variables = {
    # Required for fcitx5 support in kitty
    GLFW_IM_MODULE = "ibus";
  };
}
