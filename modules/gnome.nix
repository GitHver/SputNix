{ pkgs, ... }:

{

# ====== Gnome Environment =================================================== #
  services.xserver = {
    enable = true;			# X11 windowing system.
    displayManager.gdm.enable = true;	# GNOME Display Manager.
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;	# GNOME Desktop Environment.
  };
  services.gnome.core-utilities.enable = false;
  programs.dconf.enable = true;
									
# ====== Gnome apps & packages =============================================== #
  environment.systemPackages = with pkgs; [
  # ==== Gnome core ================== #
  # name of package			# (name in application view) short description
    gnome-console			# (console) gnome's terminal emulator
    gnome.nautilus			# (files) file manager
    gnome-text-editor			# (text editor) a basic text editor
    gnome.gnome-system-monitor		# (system monitor) resource monitor
    gnome.gnome-disk-utility		# (disks) disk formatter
    gnome.gnome-tweaks			# (tweaks) extra gnome settings
  # ==== Gnome extra ================= #
    gnome.file-roller			# (archive manager) file extractor
    gnome.baobab			# (disk usage analyzer) storege space viewer
    gnome.simple-scan			# (document scaner) printer interfacer
    gnome.evince			# (document viewer) yeah.
    gnome.gnome-clocks			# (clocks) clock and timer util
    gnome.gnome-characters		# (characters) special characters and emojis
    gnome.gnome-font-viewer		# (fonts) font picker
    gnome-connections			# (connections) remote desktop connections
    gnome.gnome-logs			# (logs) system logs
    gnome.gnome-calculator		# (calculator) a... calcualtor
  # ==== Gnome media ================= #
    loupe				# (image viewer) photo booth
    gnome.gnome-music			# (music) music player
    gnome.totem				# (videos) video player
  ];

# ====== Excluded software =================================================== #
  environment.gnome.excludePackages = with pkgs; [ 
    gnome-tour      # you don't need this
  ];

}
