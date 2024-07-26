{
  description = "Nixos config flake";
     
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nix-minecraft.url = "github:CartConnoisseur/nix-minecraft";
  };

  outputs = {nixpkgs, ...} @inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/c-pc/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          inputs.nix-minecraft.nixosModules.minecraft-servers
        ];
      };

      copenhagen = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/copenhagen/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence
          inputs.nix-minecraft.nixosModules.minecraft-servers
        ];
      };
    };
  };
}
