{ ... }:

{
  networking = {
    hostName = "c-pc";
    hostId = "23ce94ff";

    useDHCP = true;

    wireless = {
      enable = true;

      environmentFile = "/persist/secrets/wireless.env";
      networks = {
        "The Dwyers".psk = "@PSK@";
      };
    };

    firewall = {
      enable = false;

      allowedTCPPorts = [ 8096 50000 ];
      allowedUDPPorts = [ ];
    };
  };
}
