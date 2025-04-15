{ lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = [
    ./hardware.nix
    ./network.nix
  ];

  cxl = {
    system = {
      hostname = "copenhagen";
      id = "a50062ff";
      
      impermanence.enable = true;
      impermanence.home.enable = true;
    };

    suites.common.enable = true;

    services = {
      ssh = {
        enable = true;
        port = 42069;
      };

      web = {
        personal.enable = true;
        landing.enable = true;
        images.enable = true;
        stargazers.enable = true;
      };

      minecraft = {
        stargazers = {
          enable = true;
          port = 25566;
        };

        zenith = {
          enable = true;
          port = 25569;
        };
      };
    };
  };

  services = {
    pcscd.enable = true;
    udev.enable = true;
  };

  snowfallorg.users."c" = {
    admin = true;

    config = {
      cxl.tools.git.key = "DE64538967CA0C68";
    };
  };

  users.users = {
    root.hashedPasswordFile = "/secrets/passwords/root";

    "c" = {
      hashedPasswordFile = "/secrets/passwords/c";

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIDO8JxqS7B2n3YlNtlVMZGARi+GG/z7wLiiyl52qSZc caroline@larimo.re" # c-pc
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGftQ5W8QMIVhgDijreliiMgIqwQvxwTkpMftJdQWu+ caroline@larimo.re" # phoenix
      ];

      extraGroups = [ "minecraft" ];
    };
  };

  system.stateVersion = "23.11";
}