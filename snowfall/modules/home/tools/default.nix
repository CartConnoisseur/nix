{ lib, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = [
    (mkSimpleTool "cloc" {})
    (mkSimpleTool "ffmpeg" {})
  ];
}
