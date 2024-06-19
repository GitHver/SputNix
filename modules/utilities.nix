{ pkgs, ... }:

{

# ==== System packages ======================================================= #
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
  # == pkgs ========================== #
    wget
    zip
    unzip
    libgcc
    gnumake
    ripgrep
  # == fetch ========================= #
    neofetch
    cpufetch
  # == Misc ========================== #
    wineWowPackages.stable
  ];

}
