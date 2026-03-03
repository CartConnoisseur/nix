{ ... }:

# git.kernel.org version (kr/korg-deployment branch)
final: prev: {
  cgit = (prev.cgit.override {
    stdenv = prev.gcc14Stdenv;
  }).overrideAttrs (old: rec {
    commit = "1a336d923ac6639a3de017fe030989a933193ee7";
    version = "git-${commit}";

    src = prev.fetchurl {
      url = "https://git.kernel.org/pub/scm/infra/cgit.git/snapshot/cgit-${commit}.tar.gz";
      sha256 = "sha256-1UHqvKopZouy0ZZMYI1hRLOekPv1fwKMsWQoeWsZRgU=";
    };

    gitSrc = prev.fetchurl {
      url = "mirror://kernel/software/scm/git/git-2.43.0.tar.xz";
      sha256 = "sha256-VEZgPnPZEXgdJZ5WV1Dc0nekKDbI45LKyRzxN6qbduw=";
    };
  });
}
