{ pkgs, ... }:

{
  environment = {
    localBinInPath = true;

    variables = {
      EDITOR = "${pkgs.vim}/bin/vim";
    };
  };
}
