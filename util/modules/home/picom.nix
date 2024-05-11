{ ... }:

{
  services.picom = {
    enable = true;

    backend = "glx";
    vSync = true;

    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation  = 2;
      };
    };
  };
}
