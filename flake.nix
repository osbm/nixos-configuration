{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # stylix.url = "github:danth/stylix/master";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";

    dotfiles = {
      url = "github:osbm/dotfiles";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      vscode-server,
      sops-nix,
      ...
    }:
    {
      nixosConfigurations = {
        # revision = self.shortRev or self.dirtyShortRev or self.lastModified or "unknown";
        tartarus = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hosts/tartarus/configuration.nix
            vscode-server.nixosModules.default
            sops-nix.nixosModules.sops
            # stylix.nixosModules.stylix
          ];
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
