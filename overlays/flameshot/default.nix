{ ... }:

#TODO: until https://github.com/flameshot-org/flameshot/issues/4391 is fixed
final: prev: {
  flameshot = prev.flameshot.overrideAttrs (old: rec {
    version = "12.1.0-unstable-2025-05-04";

    src = prev.fetchFromGitHub {
      owner = "flameshot-org";
      repo = "flameshot";
      rev = "f4cde19c63473f8fadd448ad2056c22f0f847f34";
      hash = "sha256-B/piB8hcZR11vnzvue/1eR+SFviTSGJoek1w4abqsek=";
    };

    patches = [];

    nativeBuildInputs = with prev; [
      cmake
      libsForQt5.qttools
      libsForQt5.qtsvg
      libsForQt5.wrapQtAppsHook
      makeBinaryWrapper
    ];

    buildInputs = with prev; [
      libsForQt5.qtbase
      libsForQt5.kguiaddons
    ];
  });
}
