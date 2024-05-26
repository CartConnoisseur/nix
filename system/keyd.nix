{ ... }:

{
  services.keyd = {
    enable = true;

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
}
