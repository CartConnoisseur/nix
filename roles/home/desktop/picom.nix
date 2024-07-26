{ ... }:

{
  services.picom = {
    backend = "glx";
    vSync = true;

    settings = {
      blur = {
        method = "gaussian";
        size = 10;
        deviation  = 2;
      };

      blur-background-exclude = [
        "window_type = 'dock'"
      ];
    };
  };
}
