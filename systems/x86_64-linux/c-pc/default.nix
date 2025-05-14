{ lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; {
  imports = [
    ./hardware.nix
    ./network.nix
  ];

  cxl = {
    system = {
      hostname = "c-pc";
      id = "23ce94ff";
      
      impermanence.enable = true;
      impermanence.home.enable = true;

      fonts.nerdfonts = true;
      fonts.extra = with pkgs; [
        minecraftia
      ];
    };

    suites = {
      common.enable = true;
      desktop.enable = true;
      gaming.enable = true;
    };
  };

  services = {
    printing.enable = true;
    udev.enable = true;
  };

  snowfallorg.users."c" = {
    admin = true;

    home.config = {
      cxl = {
        desktop.enable = true;
        tools.git.key = "314C14641E707B68";
      };
    };
  };

  users.users = {
    root.hashedPasswordFile = "/secrets/passwords/root";
    "c".hashedPasswordFile = "/secrets/passwords/c";
  };

  system.stateVersion = "23.11";
}
