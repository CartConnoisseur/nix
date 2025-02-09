{ ... }:

{
  networking = {
    useDHCP = true;

    wireless = {
      enable = true;
      
      # Import /etc/wpa_supplicant.conf networks
      allowAuxiliaryImperativeNetworks = true;
    };

    firewall.enable = true;
  };

  environment.etc."wpa_supplicant.conf" = {
    source = "/secrets/wireless.conf";
  };
}
