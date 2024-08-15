{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      jdinhlife.gruvbox
      vscode-icons-team.vscode-icons

      jnoortheen.nix-ide
      golang.go
      ziglang.vscode-zig
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "shader";
        publisher = "slevesque";
        version = "1.1.5";
        sha256 = "3dfdfb15e40c365bfbe1fecb333f7e08ab1c17a5234d9ed9a5c69914ab57d993";
      }
    ];

    userSettings = {
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.iconTheme" = "vscode-icons";
      "window.titleBarStyle" = "custom";
      "editor.fontFamily" = "monospace";

      "git.confirmSync" = false;

      "vsicons.dontShowNewVersionMessage" = true;

      "files.associations" = {
        "*.vsh" = "glsl";
        "*.fsh" = "glsl";
        "*.gsh" = "glsl";
      };

      # Zig
      "zig.initialSetupDone" = true;
      "zig.path" = "";
      "zig.formattingProvider" = "off";

      "zig.zls.path" = "";
      "zig.zls.enableAutofix" = false;
      "zig.zls.enableInlayHints" = false;
    };
  };

  xdg.desktopEntries.nixeditor = lib.mkIf config.programs.vscode.enable {
    name = "NixOS Config";
    genericName = "Edit in VSCode";
    icon = "nix-snowflake";
    exec = "${pkgs.vscodium}/bin/codium /etc/nixos";
  };
}
