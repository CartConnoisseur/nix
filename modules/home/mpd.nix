{ pkgs, ... }:

{
  services.mpd = {
    enable = true;

    musicDirectory = "~/Music";
  };

  services.mpd-mpris = {
    enable = true;
  };

  home.packages = with pkgs; [
    mpc-cli
  ];
}
