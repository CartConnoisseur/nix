{ ... }:

{
  programs.mpv = {
    config = {
      screenshot-format = "png";
      screenshot-template = "~/Pictures/Screenshots/mpv/%F/%P";
    };
  };
}
