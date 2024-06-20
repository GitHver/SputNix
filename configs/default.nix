{ pkgs, ... }:

let
  hostname = import ./../hostname.nix;
  displayname        = "Whatever you want";       # example: "John Smith"
  userdirectory-name = "your-current-directory";  # example: "john-smith"
  # some-variable = "some_value";
in

{ ###### Variable scope ########################################################

# ====== Module imports ====================================================== #
  imports = [
  ./../archive/${hostname}/hardware-configuration.nix
  ./../archive/${hostname}/extra-hardware.nix
  ./../modules/essentials.nix   # Imports essential modules
  ./../modules/gnome.nix        # the most popular desktop environment
  # ./../modules/steam.nix      # if you want steam remote play, uncomment this
  ];

  config = { ### Config scope ##################################################

# ====== Bootloader ========================================================= #
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  /* Be VERY careful when changing this, nix is unbreakable in everything
  except 2 things: messing with user paths and messing with the boot-loader.
  So make sure you know what you are doing when rebuilding any changes here.
  Best to first use a virtual machine or a "throw-away" computer. */

# ====== Network config ====================================================== #
  networking = {
    hostName = "${hostname}";     # The name of your computer.
    networkmanager.enable = true; # Networkmanager handles wifi and ethernet.
    #wireless.enable = true;      # Unneccesary, Comes packaged with most DEs.
    firewall = {                    # If you're having trouble with connection
      enable = true;                # permissions, you can disable the firewall
      #allowedTCPPorts = [ ... ];   # or open some ports here
      #allowedUDPPorts = [ ... ];   # or here.
  };};
  services.openssh.enable = false;  # Allows ssh remote connections if enabled

# ====== Localization ======================================================== #
  time.timeZone = "Europe/London";
  locale-all = "en_GB.UTF-8";       # default is "en_GB.UTF-8".
  console.keyMap = "uk";            # Sets the console keymap.
  services.xserver.xkb = {          # Set the keymap for Xserver.
    layout = "gb";
    variant = "";
  };

# ====== Nix specific settings =============================================== #
  system.stateVersion = "24.05";    # What version of Nix to use
  programs.nix-ld.enable = true;              # Nix-ld is mostly for developers.
  programs.nix-ld.libraries = with pkgs; [];  # doesn't hurt to have it though!
  nix.settings = {
    allowed-users = [ "@wheel" ];       # Note: the wheel group is for admins.
    experimental-features = [ "flakes" "nix-command" ];
  };

# ====== Miscellaneous ======================================================= #
  services.printing.enable = true;  # Printer protocols
  xdg.portal.enable = true;         # X Screen portal

# ====== User management ===================================================== #
  users.mutableUsers = true;         # Makes the home directory writeable.
  users.users = {                    # See *Users* for more info
    "${userdirectory}" = {             # example: "john-smith" see at top ↑
    description  = "${displayname}";   # example: "John Smith"
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };};

# ====== System packages ===================================================== #
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;       # See "flatpaks" for more info.
  # Below is where all the sytem-wide packages are installed.
  # go to https://search.nixos.org/packages to search for programs.
  environment.systemPackages = with pkgs; [
   #name-of-package
  # ==== pkgs ======================== #
    nerdfonts     # Font icon package.
    wl-clipboard  # Wayland Clipboard tool.
  # ==== Terminal ==================== #
    micro     # A mininal but caplable terminal text editor.
    lf        # A light weight terminal file explorer.
  # ==== Miscellaneous =============== #
    firefox   # This way you still have a browser while setting up home-manager
    git       # Best learn to use git. It *WILL* make your life easier.
  ];

};} #### End of variable & config scope. #######################################
