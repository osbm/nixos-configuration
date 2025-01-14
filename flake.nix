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

    raspberry-pi-nix = {
      url = "github:nix-community/raspberry-pi-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs = {
    self,
    nixpkgs,
    vscode-server,
    agenix,
    osbm-nvim,
    home-manager,
    raspberry-pi-nix,
    nixos-hardware,
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
            environment.systemPackages = [
              agenix.packages.${system}.default
              osbm-nvim.packages.${system}.default
            ];
          }
        ];
        specialArgs = {
          inherit system-label;
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
            environment.systemPackages = [
              agenix.packages.${system}.default
              osbm-nvim.packages.${system}.default
            ];
          }
        ];
        specialArgs = {
          inherit system-label;
        };
      };
      harmonica = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          agenix.nixosModules.default
          ./hosts/harmonica/configuration.nix
          {
            environment.systemPackages = [
              agenix.packages.${system}.default
            ];
          }
        ];
      };
      # pochita = nixpkgs.lib.nixosSystem rec {
      #   system = "aarch64-linux";
      #   modules = [
      #     ./hosts/pochita/configuration.nix
      #     raspberry-pi-nix.nixosModules.raspberry-pi
      #     vscode-server.nixosModules.default
      #     agenix.nixosModules.default
      #     home-manager.nixosModules.home-manager
      #     {
      #       environment.systemPackages = [
      #         agenix.packages.${system}.default
      #         osbm-nvim.packages.${system}.default
      #       ];
      #     }
      #   ];
      # };
      pochita-sd = nixpkgs.lib.nixosSystem rec {
        system = "aarch64-linux";
        modules = [
          ./hosts/pochita-sd/configuration.nix
          raspberry-pi-nix.nixosModules.raspberry-pi
          raspberry-pi-nix.nixosModules.sd-image
        ];
      };
    };
    homeConfigurations = {
      # doesnt work because my different systems have different stateVersions
      # i dont know how to get the stateVersion from the current host
      osbm = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        modules = [./modules/home.nix];
        # get state version from the current hosts' configuration.nix
        # specialArgs = { stateVersion = "24.05"; };
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
  };
}
