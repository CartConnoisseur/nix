{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.vscode;
in {
  options.${namespace}.apps.vscode = with types; {
    enable = mkEnableOption "vscode";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      profiles.default = {
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
            sha256 = "sha256-Pf37FeQMNlv74f7LMz9+CKscF6UjTZ7ZpcaZFKtX2ZM=";
          }
          {
            name = "yuck";
            publisher = "eww-yuck";
            version = "0.0.3";
            sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
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
    };

    xdg.desktopEntries.nixeditor = {
      name = "NixOS Config";
      genericName = "Edit in VSCode";
      icon = "nix-snowflake";
      exec = "${pkgs.vscodium}/bin/codium /etc/nixos";
    };

    home.shellAliases = {
      "c" = "codium .";
    };
  };
}
