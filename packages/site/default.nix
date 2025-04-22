{ lib, pkgs, ... }:

pkgs.buildGoModule rec {
  pname = "site";
  version = "6612d84c63a7bbc2a5b70607f2ec32ea070c4659";

  src = pkgs.fetchFromGitHub {
    owner = "CartConnoisseur";
    repo = "site";
    rev = "${version}";
    hash = "sha256-n54+LdtMyjoLfaFqd7tcDQqBiYCdUW/Rs67Vc4QwEJ0=";
  };

  vendorHash = "sha256-2/4Wv7nsaT0wnUzkRgHKpSswigDj9nOvlmYXK29rvLU=";

  # kinda a hack, but whatever
  postBuild = ''
    mkdir -p $out/share/site
    cp -r $src/* $out/share/site/
  '';

  meta = {
    description = "personal site";
    homepage = "https://github.com/CartConnoisseur/site";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ CartConnoisseur ];
  };
}