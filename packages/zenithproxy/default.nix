{ lib, pkgs, stdenv, ... }:

let
  zenithproxy-launcher = stdenv.mkDerivation rec {
    pname = "zenithproxy-launcher";
    version = "v3";

    src = pkgs.fetchzip {
      url = "https://github.com/rfresh2/ZenithProxy/releases/download/launcher-${version}/ZenithProxy-launcher-linux-amd64.zip";
      hash = "sha256-ImoPNNxn3kpOWGkXwgQBAj/dJlK9BR50PSJnTwUVxU8=";
    };

    installPhase = ''
      runHook preInstall
      install -Dm755 launch -t $out/bin
      runHook postInstall
    '';
  };
in pkgs.buildFHSEnv {
  name = "zenithproxy";

  targetPkgs = (pkgs: with pkgs; [
    zenithproxy-launcher
    zlib
  ]);

  runScript = pkgs.writeShellScript "zenithproxy-wrapper" ''
    rm -f ./launch
    cp "${zenithproxy-launcher}/bin/launch" ./launch
    shift; exec ./launch "$@"
  '';

  meta = {
    description = "2b2t minecraft proxy / bot";
    homepage = "https://github.com/rfresh2/ZenithProxy";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ CartConnoisseur ];
  };
}
