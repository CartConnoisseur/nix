{ lib, pkgs, stdenv, ... }:

#TODO: temp package
stdenv.mkDerivation rec {
  pname = "minecraft-server";
  version = "b1.7.3";

  src = pkgs.fetchurl {
    url = "https://files.betacraft.uk/server-archive/beta/${version}.jar";
    hash = "sha256-AzoSfkolpgsDjxU2nIkwWj1TdSJCoc/xGulklU55uk0=";
  };

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out/bin $out/lib/minecraft
    cp -v $src $out/lib/minecraft/server.jar

    cat > $out/bin/minecraft-server << EOF
    #!/bin/sh
    exec ${pkgs.jre8_headless}/bin/java \$@ -jar $out/lib/minecraft/server.jar nogui
    EOF

    chmod +x $out/bin/minecraft-server
  '';

  dontUnpack = true;

  meta = with lib; {
    description = "Minecraft Server";
    homepage = "https://minecraft.net";
    license = licenses.unfreeRedistributable;
    platforms = platforms.unix;
    maintainers = with maintainers; [ CartConnoisseur ];
    mainProgram = "minecraft-server";
  };
}
