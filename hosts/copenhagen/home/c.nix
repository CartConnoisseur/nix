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
}
