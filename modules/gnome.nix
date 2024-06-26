{lib, pkgs, config, ... }:

{
 #====<< Gnome Environment >>==================================================>
  services.xserver = {
    enable = true;                      # Enable th X11 windowing system.
    displayManager.gdm.enable = true;   # Use the Gnome Display Manager.
    displayManager.gdm.wayland = true;  # let GDM run on wayland.
    desktopManager.gnome.enable = true; # GNOME Desktop Environment.
  };
  services.gnome.core-utilities.enable = false; # Disables Gnome apps
  programs.dconf.enable = true;

 #====<< Excluded software >>==================================================>
  environment.gnome.excludePackages = with pkgs; [ 
    gnome-tour      # you don't need this
  ];

  # once you have chosen a terminal emulator and a file explorer in your
  # home.nix, delete the lines bellow:
  environment.systemPackages = with pkgs; [ 
    gnome-console
    gnome.nautilus
  ];

}
