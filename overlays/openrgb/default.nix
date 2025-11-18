{ ... }:

final: prev: {
  openrgb = prev.openrgb.overrideAttrs (old: {
    patches = [
      ./g733.patch
    ] ++ prev.openrgb.patches;
  });
}
