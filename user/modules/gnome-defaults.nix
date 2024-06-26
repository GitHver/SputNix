{pkgs, config, ... }:

let
  gnomeCoreUtils = with pkgs; [
  # ==== Gnome core ================== #
    #gnome-console               # (console) gnome's terminal emulator
    gnome.nautilus              # (files) file manager
    gnome-text-editor           # (text editor) a basic text editor
    gnome.gnome-system-monitor  # (system monitor) resource monitor
    gnome.gnome-disk-utility    # (disks) disk formatter
    gnome.gnome-tweaks          # (tweaks) extra gnome settings
  # ==== Gnome extra ================= #
    gnome.file-roller           # (archive manager) file extractor
    gnome.baobab                # (disk usage analyzer) storege space viewer
    gnome.simple-scan           # (document scaner) printer interfacer
    gnome.evince                # (document viewer) yeah.
    gnome.gnome-clocks          # (clocks) clock and timer util
    gnome.gnome-characters      # (characters) special characters and emojis
    gnome.gnome-font-viewer     # (fonts) font picker
    gnome-connections           # (connections) remote desktop connections
    gnome.gnome-logs            # (logs) system logs
    gnome.gnome-calculator      # (calculator) a... calculator
    gnome.dconf-editor          # (dconf editor) GUI for dconf
  # ==== Gnome media ================= #
    loupe                       # (image viewer) photo booth
    gnome.gnome-music           # (music) music player
    gnome.totem                 # (videos) video player  
  ];
  gnomeExtensionsList = with pkgs.gnomeExtensions; [
/*1*/ paperwm
/*2*/ vitals
/*3*/ dash-to-dock
/*4*/ blur-my-shell
/*5*/ unblank
/*6*/ custom-accent-colors
  ];
# *1 A scrollable tiling windowmanager. Makes Gnome usable.
# *2 A rescource monitor for the panel. *More stable* than system monitor.
# *3 Moves the dash to a dock format to be always visable without the super key
# *4 controlls the blur for: panel, dash, applications and lock screen.
# *5 Prevents the screen from blanking
# *6 choose an accent colour for the gnome interface
in {

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.packages = gnomeCoreUtils ++ gnomeExtensionsList;

  dconf.settings = {

   #==<< Activating all extensions >>==========================================>
    "org/gnome/shell".enabled-extensions =
      (map (extension: extension.extensionUuid) gnomeExtensionsList) ++ [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        #"system-monitor@gnome-shell-extensions.gcampax.github.com"
      ];

   #
    "org/gnome/desktop/interface" = {
     #==<< General >>==================>
      color-scheme = "prefer-dark" ;
      enable-hot-corners = false;
      clock-show-weekday = true;
      clock-show-date = true;
     #==<< Fonts >>====================>
      #document-font-name = "";
      monospace-font-name = "CaskaydiaCove Nerd Font Mono Regular";
      font-antialiasing = "rgba";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,close";
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };

   #==<< Dash to Dock >>=======================================================>
    "org/gnome/shell/extensions/dash-to-dock" = {
     #==<< Transparency >>=============>
      transparency-mode = "FIXED";
      background-opacity = 0.0;
     #==<< Dash action ================>
      click-action  = "launch";
      scroll-action = "cycle-windows";
     #==<< Other >>====================>
      dock-position = "RIGHT";
      dock-fixed = true;
      extend-height = true;
      dash-max-icon-size = 38;
      show-trash = false;
      custom-theme-shrink = true;
    };

   #==<< Blur my shell >>======================================================>
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      static-blur = false;
      sigma = 0;
      brightness = 1.0;
      override-background = true;
      style-panel = 3;
    };
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      blur = true;
      style-dialogs = 0;
    };
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      static-blur = false;
      sigma = 0;
      brightness = 1.0;
    };

   #==<< PaperWM >>============================================================>
    "org/gnome/shell/extensions/paperwm" = {
      show-window-position-bar = false;
      window-gap = 5;
      selection-border-size = 0;
      selection-border-radius-top    = 12;
      selection-border-radius-bottom = 12;
      vertical-margin        = 5;
      vertical-margin-bottom = 5;
      horizontal-margin = 5;
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
     #==<< Navigation >>===============>
      # Move between windows
      switch-left   = [ "<Super>h" "<Super>Left" ];
      switch-right  = [ "<Super>l" "<Super>Right" ];
      switch-down   = [ "<Super>j" "<Super>Down" ];
      switch-up     = [ "<Super>k" "<Super>Up" ];
      # Rearange windows
      move-left     = [ "<Control><Super>h" "<Control><Super>Left" ];
      move-right    = [ "<Control><Super>l" "<Control><Super>Right" ];
      move-down     = [ "<Control><Super>j" "<Control><Super>Down" ];
      move-up       = [ "<Control><Super>k" "<Control><Super>Up" ];
      # Move between workspaces
      switch-down-workspace   = [ "<Alt><Super>j" "<Alt><Super>Down" ];
      switch-up-workspace     = [ "<Alt><Super>k" "<Alt><Super>Up" ];
      # Move between monitors
      switch-monitor-left     = [ "<Alt><Super>h" "<Alt><Super>Left" ];
      switch-monitor-right    = [ "<Alt><Super>l" "<Alt><Super>Right" ];
      # Move window between monitors
      move-monitor-left
        = [ "<Control><Alt><Super>h" "<Control><Alt><Super>Left" ];
      move-monitor-right
        = [ "<Control><Alt><Super>l" "<Control><Alt><Super>Right" ];
     #==<< Resizing windows >>=========>
      cycle-width            = ["<Shift><Super>l" "<Shift><Super>Right"];
      cycle-width-backwards  = ["<Shift><Super>h" "<Shift><Super>Left"];
      cycle-height           = ["<Shift><Super>k" "<Shift><Super>Up"];
      cycle-height-backwards = ["<Shift><Super>j" "<Shift><Super>Down"];
     #==<< Actions >>==================>
      # Common rules
      new-window    = [ "<Super>c" ];
      close-window  = [ "<Super>x" ];
      take-window   = [ "<Super>z" ];
      # Misc
      center-horizontally           = [ "<Super>b" ];
      switch-open-window-position   = [ "<Super>w" ];
      switch-focus-mode             = [ "<Super>e" ];
    };

  };

}
