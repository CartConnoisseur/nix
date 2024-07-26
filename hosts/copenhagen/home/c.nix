{ lib, pkgs, inputs, config, ...}:

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

  programs = {
    git = {
      enable = true;

      userName = "Caroline Larimore";
      userEmail = "caroline@larimo.re";

      signing = {
        key = "DE64538967CA0C68";
        signByDefault = true;
      };

      ignores = [
        "*~"
        "*.swp"
      ];
    };
  };

  home.packages = with pkgs; [
    cloc
  ];

  home.stateVersion = "23.11";
}
