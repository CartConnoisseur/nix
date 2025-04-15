{ lib, pkgs, ... }:

pkgs.buildGoModule rec {
  pname = "status";
  version = "1b1eed2494bca4add8471109481afea9fb5d4769";

  src = pkgs.fetchFromGitHub {
    owner = "CartConnoisseur";
    repo = "status";
    rev = "${version}";
    hash = "sha256-v2m5fJU2MKMDem18KS7bgYtKZAEaWRb1D/gLymzBhOw=";
  };

  vendorHash = "sha256-hkUXaFfTuewOCuo2GUhcd5mw7IgJAvLouwKaI87hFns=";

  meta = {
    description = "The worst chat app ever";
    homepage = "https://github.com/CartConnoisseur/status";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ CartConnoisseur ];
  };
}
