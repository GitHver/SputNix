{
  description = "This user's flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    hostname = import ./unique/hostname.nix;
    username = import ./unique/username.nix;
  in {

    homeConfigurations = { # User home manager <<<<<<<<<<<<<<<<<<<<<<<<<<< #
      "${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home.nix ];
      };
    }; # <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< #

  };
}
