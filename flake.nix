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
  }: {
    nixosConfigurations = let
      system-label = self.shortRev or self.dirtyShortRev or self.lastModified or "unknown";
    in {
      tartarus = nixpkgs.lib.nixosSystem {
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
        specialArgs = {
          inherit system-label;
        };
      };
      ymir = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/ymir/configuration.nix
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
        specialArgs = {
          inherit system-label;
        };
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
        specialArgs = {
          inherit system-label;
        };
      };
      pochita-sd = nixpkgs-rpi.lib.nixosSystem {
        modules = [
          ./hosts/pochita-sd/configuration.nix
          raspberry-pi-nix.nixosModules.raspberry-pi
          raspberry-pi-nix.nixosModules.sd-image
        ];
      };
      myISO = nixpkgs.lib.nixosSystem {
        modules = [
          "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
          ./hosts/iso/configuration.nix
        ];
      };
    };
    homeConfigurations = {
      # doesnt work because my different systems have different stateVersions
      # I dont know how to get the stateVersion from the current host
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
