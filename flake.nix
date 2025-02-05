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
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      snowfall = {
        root = ./snowfall;
        namespace = "cxl";

        meta = {
          name = "cxl";
          title = "cxl flake";
        };
      };

      systems.modules.nixos = with inputs; [
        inputs.home-manager.nixosModules.default
        impermanence.nixosModules.impermanence
        nix-minecraft.nixosModules.minecraft-servers
      ];
    };
  # nixosConfigurations = {
  #   c-pc = nixpkgs.lib.nixosSystem {
  #     specialArgs = { inherit inputs; };
  #     modules = [
  #       ./hosts/c-pc/configuration.nix
  #       inputs.home-manager.nixosModules.default
  #       inputs.impermanence.nixosModules.impermanence
  #       inputs.nix-minecraft.nixosModules.minecraft-servers
  #       (import ./overlays)
  #     ];
  #   };

  #   copenhagen = nixpkgs.lib.nixosSystem {
  #     specialArgs = { inherit inputs; };
  #     modules = [
  #       ./hosts/copenhagen/configuration.nix
  #       inputs.home-manager.nixosModules.default
  #       inputs.impermanence.nixosModules.impermanence
  #       inputs.nix-minecraft.nixosModules.minecraft-servers
  #     ];
  #   };
}
