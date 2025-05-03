{ lib, pkgs, stdenvNoCC, ... }:

let
  engine = stdenvNoCC.mkDerivation rec {
    pname = "java-decompiler-engine";
    version = "242.26775.15";

    src = pkgs.fetchurl {
      url = "https://www.jetbrains.com/intellij-repository/releases/com/jetbrains/intellij/java/${pname}/${version}/${pname}-${version}.jar";
      hash = "sha256-y9/Jmh+FCmbBQdbUE4jPcTL+4gylxahP7sGPVElec4s=";
    };

    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      install -Dm755 $src $out
      runHook postInstall
    '';
  };
in pkgs.writeShellScriptBin "fernflower" ''
  exec ${pkgs.jdk}/bin/java -jar ${engine} "$@"
''
