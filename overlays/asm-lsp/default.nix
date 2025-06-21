{ ... }:

final: prev: {
  asm-lsp = prev.asm-lsp.overrideAttrs (old: rec {
    version = "git";

    src = prev.fetchFromGitHub {
      owner = "bergercookie";
      repo = "asm-lsp";
      rev = "5a2c112aa3b41ed736064d7f2bf4cc41775fd53f";
      hash = "sha256-Kz1+SbFD0NTX3Sj22mdX1RV/qLbZfEyr1gc8T7nwOmQ=";
    };

    cargoDeps = prev.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-4GbKT8+TMf2o563blj8lnZTD7Lc+z9yW11TfxYzDSg4=";
    };
  });
}
