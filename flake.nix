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
    nix-minecraft.url = "github:CartConnoisseur/nix-minecraft";

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
    ];

    homes.modules = with inputs; [
      nixvim.homeManagerModules.nixvim
    ];

    overlays = with inputs; [
      nix-minecraft.overlay
    ];

    channels-config.allowUnfreePredicate = pkg: builtins.elem (inputs.nixpkgs.lib.getName pkg) [
      "discord"
      "obsidian"
      "minecraft-server"
    ];
  };
}
