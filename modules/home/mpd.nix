{ ... }:

{
  services.mpd = {
    enable = true;
  };

  services.mpd-mpris = {
    enable = true;
  };

  home.packages = with pkgs; [
    mpc-cli
  ];
}
