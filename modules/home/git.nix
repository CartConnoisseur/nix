{ ... }:

{
  programs.git = {
    enable = true;

    userName = "Caroline Larimore";
    userEmail = "caroline@larimo.re";

    signing = {
      key = "314C14641E707B68";
      signByDefault = true;
    };
  };
}
