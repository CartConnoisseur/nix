{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      openrgb = prev.openrgb.overrideAttrs (old: {
        src = prev.fetchFromGitLab {
          owner = "CalcProgrammer1";
          repo = "OpenRGB";
          rev = "44c839c1160864c25170306bc1ab392333a682af";
          hash = "sha256-k/Rt8VgaZJGktKj/Lv9G/EwtFykk1n1K2Mc3unEpF48=";
        };

        postPatch = ''
          patchShebangs scripts/build-udev-rules.sh
          substituteInPlace scripts/build-udev-rules.sh \
            --replace /bin/chmod "${prev.coreutils}/bin/chmod"
          substituteInPlace scripts/build-udev-rules.sh \
            --replace /usr/bin/env "${prev.coreutils}/bin/env"
        '';
      });
    })
  ];
}