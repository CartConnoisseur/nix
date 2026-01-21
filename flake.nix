{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    k95aux = {
      url = "github:CartConnoisseur/k95aux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.snowfall-lib.mkFlake {
    inherit inputs;
    src = ./.;

    snowfall = {
      root = ./.;
      namespace = "cxl";

      meta = {
        name = "cxl";
        title = "cxl flake";
      };
    };

    systems.modules.nixos = with inputs; [
      impermanence.nixosModules.impermanence
      nix-minecraft.nixosModules.minecraft-servers
      k95aux.nixosModules.k95aux
    ];

    homes.modules = with inputs; [
      nixvim.homeModules.nixvim
    ];

    overlays = with inputs; [
      nix-minecraft.overlay
    ];

    channels-config.allowUnfreePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
      "discord"
      "obsidian"
      "minecraft-server"
      "steamcmd"
      "steam-unwrapped"
    ];

    channels-config.permittedInsecurePackages = [
      "qtwebengine-5.15.19"
    ];
  };
}
