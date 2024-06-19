{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      # nixpkgs 24.05 version
      # Unstable doesn't work, and, frankly, I can't be bothered to fix it
      #TODO: update to latest version, eventually
      package = (pkgs.gruvbox-gtk-theme.overrideAttrs {
        version = "unstable-2023-05-28";
        src = pkgs.fetchFromGitHub {
          owner = "Fausto-Korpsvart";
          repo = "Gruvbox-GTK-Theme";
          rev = "c0b7fb501938241a3b6b5734f8cb1f0982edc6b4";
          hash = "sha256-Y+6HuWaVkNqlYc+w5wLkS2LpKcDtpeOpdHnqBmShm5Q=";
        };
      });
      name = "Gruvbox-Dark-B";
    };

    font = {
      name = "monospace";
      size = 8;
    };
  };
}