{ options, config, lib, pkgs, namespace, ... }:

with lib; with lib.${namespace}; let
  cfg = config.${namespace}.apps.discord;
  impermanence = config.${namespace}.impermanence;
  desktop = config.${namespace}.desktop;
in {
  options.${namespace}.apps.discord = with types; {
    enable = mkEnableOption "discord";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (discord.override {
        withVencord = false;
        withOpenASAR = false;
      })
      vesktop
    ];

    home.persistence.${impermanence.location} = {
      directories = [
        ".config/discord"
        ".config/Vencord"
        ".config/vesktop"
      ];
    };

    xdg.configFile."Vencord/themes/nix.theme.css".text = let c = desktop.theme.colors; in ''
      @import url(https://mwittrien.github.io/BetterDiscordAddons/Themes/BasicBackground/BasicBackground.css);

      :root {
        --transparencycolor:            0, 0, 0;
        --transparencyalpha:            0.0;
        --messagetransparency:          0.0;
        --guildchanneltransparency:     0.15;
        --chatinputtransparency:        0.0;
        --memberlisttransparency:       0.15;
        --settingsicons:                0;
        /* A discord update messed up transparancy, and for now eyeballing it works fine */
        /* --background:                   rgba(0, 0, 0, 0.8); */
        --background:                   rgba(0, 0, 0, 0.55);
        --backdrop:                     rgba(0, 0, 0, 0);        
        --version1_0_5:                 none;

        --accentcolor:                  ${hexToRGBString ", " c.accent};

        --textbrightest:                ${hexToRGBString ", " c.fg0};
        --textbrighter:                 ${hexToRGBString ", " c.fg1};
        --textbright:                   ${hexToRGBString ", " c.fg2};
        --textdark:                     ${hexToRGBString ", " c.fg3};
        --textdarker:                   ${hexToRGBString ", " c.fg4};
        --textdarkest:                  ${hexToRGBString ", " c.brightBlack};
      }
    '';
  };
}
