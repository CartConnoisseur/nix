{ lib, pkgs, inputs, config, ...}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.stateVersion = "23.11";

  home.persistence."/persist/home/c" = {
    directories = [
      ".gnupg"
      ".ssh"
      
      ".local/bin"
    ];
    allowOther = true;
  };

  home.packages = with pkgs; [
    cloc
  ];
}
