{ pkgs, ... }:

  let
    hostname = import ./../hostname.nix;
  in

{ ###### Variable scope ########################################################

# ====== Module imports ====================================================== #
  imports = [
    ./../archive/${hostname}/hardware-configuration.nix
    ./../archive/${hostname}/extra-hardware.nix
    ./../modules/userlogicT1.nix
    ./../modules/userlogicT2.nix
    ./../modules/localization.nix
    ./../modules/pipewire.nix
    ./../modules/utilities.nix
    ./../modules/gnome.nix
    # ./../modules/steam.nix # if you want steam, uncomment this
  ];
		
  config = { ### Config scope ##################################################

# ====== Bootloader ========================================================== #
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  /* Be VERY careful when changing this, nix is unbreakable in everything
  except 2 things: messing with user paths and messing with the boot-loader.
  So make sure you know what you are doing when rebuilding any changes here.
  Best to first use a virtual machine or a "throw-away" computer */

# ====== Network config ====================================================== #
  networking = {
    hostName = "${hostname}";		# The name of your computer
    networkmanager.enable = true;
    #wireless.enable = true;		# comes with most DEs
    firewall = {
      enable = true;
      #allowedTCPPorts = [ ... ];
      #allowedUDPPorts = [ ... ];
  };};
  services.openssh.enable = false;

# ====== Localization ======================================================== #
  time.timeZone = "Europe/London";
  locale-all = "en_GB.UTF8";
  console.keyMap = "uk";		# Configure console keymap
  services.xserver.xkb = {        # Configure keymap in X11
    layout = "gb";
    variant = "";
  };

# ====== Nix specific settings =============================================== #
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [];
  users.mutableUsers = true;
  nix.settings = {
    allowed-users = [ "@wheel" ];
    experimental-features = [ "flakes" "nix-command" ];
  };

# ====== Miscellaneous ======================================================= #
  services.printing.enable = true;
  xdg.portal.enable = true;

# ====== System packages ===================================================== #
  system.stateVersion = "24.05";
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
  # ==== pkgs ======================== #
    nerdfonts
    git
    wl-clipboard
  # ==== Terminal ==================== #
    micro
    lf
  # ==== Miscellaneous =============== #
    firefox
  ];

};} #### End of variable & config scope. #######################################
