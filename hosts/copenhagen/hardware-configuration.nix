{ config, lib, pkgs, modulesPath, ... }:

#TODO: regenerate on physical copenhagen hardware

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
