{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        tartarus = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix ];
          # revision = self.shortRev or self.dirtyShortRev or self.lastModified or "unknown";
        };
      };
    };
}
