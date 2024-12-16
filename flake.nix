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

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # stylix.url = "github:danth/stylix/master";
    # stylix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    osbm-nvim.url = "github:osbm/osbm-nvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    vscode-server,
    sops-nix,
    osbm-nvim,
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
          sops-nix.nixosModules.sops
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
          sops-nix.nixosModules.sops
        ];
        specialArgs = {
          inherit pkgs-unstable system-label osbm-nvim;
        };
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
