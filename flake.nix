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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscode-server.inputs.nixpkgs.follows = "nixpkgs";

    # sops-nix.url = "github:Mic92/sops-nix";
    # sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";

    # stylix.url = "github:danth/stylix/master";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    osbm-nvim.url = "github:osbm/osbm-nvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    vscode-server,
    agenix,
    osbm-nvim,
    home-manager,
    ...
  }: {
    nixosConfigurations = let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      system-label = self.shortRev or self.dirtyShortRev or self.lastModified or "unknown";
    in {
      tartarus = nixpkgs.lib.nixosSystem rec {
        inherit system;
        modules = [
          ./hosts/tartarus/configuration.nix
          vscode-server.nixosModules.default
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
        ];
        specialArgs = {
          inherit pkgs-unstable system-label osbm-nvim;
        };
      };
      ymir = nixpkgs.lib.nixosSystem rec {
        inherit system;
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
          inherit pkgs-unstable system-label osbm-nvim;
        };
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
