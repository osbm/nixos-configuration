{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
  }: {
      nixosConfigurations = {
        # revision = self.shortRev or self.dirtyShortRev or self.lastModified or "unknown";
        tartarus = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [ ./configuration.nix ];
          specialArgs = {
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            system-label = self.shortRev or self.dirtyShortRev or self.lastModified or "unknown";
          };
        };
      };
    };
}
