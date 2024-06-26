{ pkgs, ... }:

let
  hostname = import ./../hostname.nix;
  displayname   = "Whatever you want";       # example: "John Smith"
  userdirectory = "your-current-directory";  # example: "john-smith"
  # some-variable = "some_value";
in

{ ############################ Variable scope ##################################

 #=====<< Module imports >>=====================================================>
  imports = [
  ./../archive/${hostname}/hardware.nix
  ./../modules/essentials.nix   # Imports essential modules
  ./../modules/gnome.nix        # The most popular desktop environment
  #./../modules/steam.nix        # If you want steam remote play, uncomment this
  ];

  config = { ################# Config scope ####################################

 #====<< User management >>====================================================>
  users.mutableUsers = true;         # Makes the home directory writeable.
  users.users = {                    # See *Users* for more info
    "${userdirectory}" = {             # example: "john-smith" see at top ↑
    description = "${displayname}";    # example: "John Smith"
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [ 
      gnome-console gnome-text-editor gnome.nautilus firefox
    ]; /* These programs are provided in the home manager home.nix, but due
      to needing to build this configuration once before being able to use
      home manager, these essential programs are here so that they dont
      dissapear mid setup. remove these once you have home manager set up. */
  };};
  # Uncomment the below if you want to use home manager as a module
  #home-manager.users.${username} = imports ./../user/home.nix;

 #====<< System packages >>====================================================>
  services.flatpak.enable = true;       # See "flatpaks" for more info.
  # Below is where all the sytem-wide packages are installed.
  # Go to https://search.nixos.org/packages to search for programs.
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ 
   #==<< Terminal utilities >>=========>
    zellij    # User friendly terminal multiplexer
    helix     # No nonsense terminal modal text editor
    yazi      # Batteries included terminal file manager
    git       # Best learn to use git. it *WILL* make your life easier.
  ];

 #=====<< Bootloader >>========================================================>
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  /* Be VERY careful when changing this, nix is unbreakable in everything
  except 2 things: messing with user paths and messing with the boot-loader.
  So make sure you know what you are doing when rebuilding any changes here.
  Best to first use a virtual machine or a "throw-away" computer. */

 #====<< Network config >>=====================================================>
  networking = {
    hostName = "${hostname}";     # The name of your computer.
    networkmanager.enable = true; # Networkmanager handles wifi and ethernet.
    #wireless.enable = true;      # Unneccesary, Comes packaged with most DEs.
    firewall = {                    # If you're having trouble with connection
      enable = true;                # permissions, you can disable the firewall
      #allowedTCPPorts = [ ... ];   # or open some ports here
      #allowedUDPPorts = [ ... ];   # or here.
  };};
  services.openssh.enable = false;

 #====<< Localization >>=======================================================>
  time.timeZone = "Atlantic/Reykjavik";
  i18n.defaultLocale  = "en_GB.UTF-8";  # Set default localization.
  extraLocaleSettings = "is_IS.UTF-8";  # Set main localization.
  console.keyMap = "is-latin1";         # Sets the console keymap.
  services.xserver.xkb = {              # Set the keymap for Xserver.
    layout = "is";
    variant = "";
  };

 #====<< Nix specific settings >>==============================================>
  system.stateVersion = "24.11";              # What version of Nix to use
  programs.nix-ld.enable = true;              # Nix-ld is mostly for developers.
  programs.nix-ld.libraries = with pkgs; [];  # doesn't hurt to have it though!
  nix.settings = {
    allowed-users = [ "@wheel" ];       # Note: the wheel group is for admins.
    experimental-features = [ "flakes" "nix-command" ];
  };

 #====<< Miscellaneous >>======================================================>
  xdg.portal.enable = true;         # XDG Desktop portal (for nix and flatpaks)
  programs.xwayland.enable = true;  # For running X11 applications
  services.printing.enable = true;  # Printer protocols
  fonts.packages = with pkgs; [     # Fonts to import
    maple-mono-NF
    (nerdfonts.override { fonts = [ # Nerd Fonts for displaying special glyphs
      "CascadiaCode"
      #"FiraCode"
    ]; })
  ];

};} ################ End of variable & config scope. ###########################
