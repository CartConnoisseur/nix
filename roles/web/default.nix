{ ... }:

{
  imports = [
    ./images
    ./personal
    ./stargazers
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "caroline@larimo.re";
  };
}
