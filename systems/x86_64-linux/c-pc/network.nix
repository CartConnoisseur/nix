{ ... }:

{
  networking = {
    useDHCP = true;

    wireless = {
      enable = true;
      
      # Import /etc/wpa_supplicant.conf networks
      allowAuxiliaryImperativeNetworks = true;
    };

    firewall = {
      enable = false;

      allowedTCPPorts = [
        8096 # jellyfin
        50000 # qbittorrent
      ];
      
      allowedUDPPorts = [
        51820 # wireguard
      ];
    };

    wg-quick.interfaces.wg0.configFile = "/secrets/wireguard.conf";
  };

  environment.etc."wpa_supplicant.conf" = {
    source = "/secrets/wireless.conf";
  };
}
