{ config, ... }:

{
  programs.git = {
    userName = "Caroline Larimore";
    userEmail = "caroline@larimo.re";

    signing = {
      key = config.home.roles.dev.key;
      signByDefault = true;
    };

    ignores = [
      "*~"
      "*.swp"
    ];
  };
}
