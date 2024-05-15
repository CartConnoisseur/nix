{ ... }:

{
  networking = {
    hostName = "c-pc";
    hostId = "23ce94ff";

    useDHCP = true;

    wireless = {
      enable = true;
      networks = import ./wifi.nix;
    };

    firewall = {
      enable = false;

      allowedTCPPorts = [ 8096 50000 ];
      allowedUDPPorts = [ ];
    };
  };
}

