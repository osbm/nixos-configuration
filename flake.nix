{
  description = "My system configuration";
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    osbm-nvim.url = "github:osbm/osbm-nvim";
  };

  outputs = {
    self,
    nixpkgs,
    vscode-server,
    agenix,
    osbm-nvim,
    home-manager,
    ...
  }: {
    nixosConfigurations = let
      system-label = self.shortRev or self.dirtyShortRev or self.lastModified or "unknown";
    in {
      tartarus = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          ./hosts/tartarus/configuration.nix
          vscode-server.nixosModules.default
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [agenix.packages.${system}.default];
          }
        ];
        specialArgs = {
          inherit system-label osbm-nvim;
        };
      };
      ymir = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        modules = [
          ./hosts/ymir/configuration.nix
          vscode-server.nixosModules.default
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [agenix.packages.${system}.default];
          }
        ];
        specialArgs = {
          inherit system-label osbm-nvim;
        };
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
