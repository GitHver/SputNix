{ description = "SputNix flake!";

inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  home-manager.url = "github:nix-community/home-manager";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
};
  
outputs = { self, nixpkgs, ... }@inputs:

{ nixosConfigurations = {

    # If you plan on using home manager with out sudo, or want
    # to upate your user packages without affecting the system,
    # use this. Also the only way for mutltiple users to be able
    # to manage their own home with affecting other users.
    Standalone = nixpkgs.lib.nixosSystem { 
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configs/default.nix 
      ];
    };

    # If you want home manager as a module, use this.
    Module     = nixpkgs.lib.nixosSystem { 
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configs/default.nix 
        inputs.home-manager.nixosModules.default  
      ];
    };

    # Using the following command, a result directory will be made
    # with a custom ISO in the result/bin directory.
    # $ nix build \.#nixosConfigurations.ISO.config.system.build.isoimage
    # put your packages you want on the ISO in ./configd/ISO-image.nix
    ISO        = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./configs/ISO-image.nix ];
    };

};};

}
