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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-rpi.url = "github:NixOS/nixpkgs/eb62e6aa39ea67e0b8018ba8ea077efe65807dc8"; # TODO: fix this later
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    osbm-nvim = {
      url = "github:osbm/osbm-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixvim.follows = "nixvim";
    };
    raspberry-pi-nix = {
      url = "github:nix-community/raspberry-pi-nix";
      inputs.nixpkgs.follows = "nixpkgs-rpi";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
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
    nixpkgs-rpi,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      tartarus = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/tartarus/configuration.nix
          vscode-server.nixosModules.default
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [
              agenix.packages.x86_64-linux.default
              osbm-nvim.packages.x86_64-linux.default
            ];
          }
        ];
      };
      ymir = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/ymir/configuration.nix];
      };
      harmonica = nixpkgs.lib.nixosSystem {
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          agenix.nixosModules.default
          ./hosts/harmonica/configuration.nix
          {
            environment.systemPackages = [
              agenix.packages.aarch64-linux.default
            ];
          }
        ];
      };
      pochita = nixpkgs-rpi.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/pochita/configuration.nix
          raspberry-pi-nix.nixosModules.raspberry-pi
          nixos-hardware.nixosModules.raspberry-pi-5
          vscode-server.nixosModules.default
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [
              agenix.packages.aarch64-linux.default
              osbm-nvim.packages.aarch64-linux.default
            ];
          }
        ];
      };
      pochita-sd = nixpkgs-rpi.lib.nixosSystem {
        modules = [
          ./hosts/pochita-sd/configuration.nix
          raspberry-pi-nix.nixosModules.raspberry-pi
          raspberry-pi-nix.nixosModules.sd-image
        ];
      };
      myISO = nixpkgs.lib.nixosSystem {
        modules = [./hosts/iso/configuration.nix];
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
  };
}
