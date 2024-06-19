{ pkgs, lib, modulesPath, ... }:

{

# ====== Imports ============================================================= #
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

# ====== Boot process ======================================================== #
  boot.loader.systemd-boot.enable = true;  # BOOT-AR EKKI ÁN ÞESS!!!
  boot.loader.efi.canTouchEfiVariables = true;

# ====== Installed packages ================================================== #
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
  # ==== Partition utils ============= #
    disko
    parted
  # ==== Terminal Navigation ========= #
    micro
    lf
  # ==== Internet ==================== #
    wget
    git
  # ==== Other ======================= #
    nerdfonts
  ];

# ====== Nix specific settings =============================================== #
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    allowed-users = [ "@wheel" ];
  };

}
