{ config, lib, pkgs, ... }:

let
  conversion = import ../util/color-conversion.nix { inherit lib; };
in {
  home.packages = with pkgs; [
    (discord.override {
      withVencord = true;
      withOpenASAR = true;
    })
  ];

  xdg.configFile."Vencord/themes/nix.theme.css".text = let c = config.theme.colors; in ''
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

      --accentcolor:                  ${conversion.hexToRGBString ", " c.accent};

      --textbrightest:                ${conversion.hexToRGBString ", " c.fg0};
      --textbrighter:                 ${conversion.hexToRGBString ", " c.fg1};
      --textbright:                   ${conversion.hexToRGBString ", " c.fg2};
      --textdark:                     ${conversion.hexToRGBString ", " c.fg3};
      --textdarker:                   ${conversion.hexToRGBString ", " c.fg4};
      --textdarkest:                  ${conversion.hexToRGBString ", " c.brightBlack};
    }
  '';
}
