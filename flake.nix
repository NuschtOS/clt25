{
  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { disko, nixpkgs, ... }: {
    nixosConfigurations = {
      proxy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./shared.nix
          ./proxy/configuration.nix
        ];
      };

      xyzbook = nixpkgs.lib.nixosSystem {
        modules = [
          ./shared.nix
          ./xyzbook/configuration.nix
        ];
      };
    };
  };
}
