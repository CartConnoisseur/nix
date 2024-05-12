{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      jdinhlife.gruvbox
      vscode-icons-team.vscode-icons

      jnoortheen.nix-ide
      golang.go
    ];

    userSettings = {
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.iconTheme" = "vscode-icons";
      "window.titleBarStyle" = "custom";

      "git.confirmSync" = false;
    };
  };
}
