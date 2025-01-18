{ ... }:

{
  networking = {
    hostName = "c-pc";
    hostId = "23ce94ff";

    useDHCP = true;

    wireless = {
      enable = true;
      
      # Import /etc/wpa_supplicant.conf networks
      allowAuxiliaryImperativeNetworks = true;
    };

    firewall = {
      enable = false;

      allowedTCPPorts = [ 8096 50000 ];
      allowedUDPPorts = [ ];
    };
  };

  environment.etc."wpa_supplicant.conf" = {
    source = "/secrets/wireless.conf";
  };
}
