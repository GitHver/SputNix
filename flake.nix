{ description = "SputNix flake!";

inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  home-manager.url = "github:nix-community/home-manager";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
};
  
outputs = { self, nixpkgs, ... }@inputs:

{ nixosConfigurations = {
  
    default = nixpkgs.lib.nixosSystem { 
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configs/default.nix 
        #./user/home.nix      # if you want home manager as a module
      ];
    };

    ISO     = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./configs/ISO-image.nix ];
    };

};};

}
