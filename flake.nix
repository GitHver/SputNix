{ description = "SputNix flake!";

inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
};
  
outputs = { self, nixpkgs, ... }@inputs:

{ nixosConfigurations = {
  
    default = nixpkgs.lib.nixosSystem { 
      specialArgs = { inherit inputs; };
      modules = [ ./configs/default.nix ];
    };

    ISO     = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./configs/ISO-image.nix ];
    };

};};

}
