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
          ./ssh.nix
          ./proxy/configuration.nix
        ];
      };

      xyzbook = nixpkgs.lib.nixosSystem {
        modules = [
          ./ssh.nix
          ./xyzbook/configuration.nix
        ];
      };
    };
  };
}
