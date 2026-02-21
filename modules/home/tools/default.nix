{ lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = with pkgs; [
    (mkSimpleTool "cloc" {})
    (mkSimpleTool "ffmpeg" {})
    (mkSimpleTool "wine" {
      packages = [
        wineWow64Packages.stable
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
    (mkSimpleTool "serve" {
      packages = [ cxl.serve ];
    })
  ];
}
