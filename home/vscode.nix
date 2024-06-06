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
      ziglang.vscode-zig
    ];

    userSettings = {
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.iconTheme" = "vscode-icons";
      "window.titleBarStyle" = "custom";

      "git.confirmSync" = false;

      "vsicons.dontShowNewVersionMessage" = true;

      # Zig
      "zig.initialSetupDone" = true;
      "zig.path" = "";
      "zig.formattingProvider" = "off";

      "zig.zls.path" = "";
      "zig.zls.enableAutofix" = false;
      "zig.zls.enableInlayHints" = false;
    };
  };
}
