{ lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = with pkgs; [
    (mkSimpleTool "cloc" {})
    (mkSimpleTool "ffmpeg" {})
    (mkSimpleTool "wine" {
      packages = [
        wineWowPackages.stable
        winetricks
      ];
      persist = [ ".wine" ];
    })
    (mkSimpleTool "mute" {
      packages = [ cxl.mute ];
    })
    (mkSimpleTool "click" {
      packages = [ cxl.click ];
    })
    (mkSimpleTool "mkenv" {
      packages = [ cxl.mkenv ];
    })
    (mkSimpleTool "fork" {
      packages = [ cxl.fork ];
    })
  ];
}
