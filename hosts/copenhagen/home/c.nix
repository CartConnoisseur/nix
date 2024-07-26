{ config, lib, pkgs, inputs, ...}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home/c" = {
    allowOther = true;
    
    directories = [
      ".gnupg"
      ".ssh"
      
      ".local/bin"
    ];
  };

  home.roles = {
    dev = {
      enable = true;
      key = "DE64538967CA0C68";
    };
  }

  home.packages = with pkgs; [
    cloc
  ];

  home.stateVersion = "23.11";
}
