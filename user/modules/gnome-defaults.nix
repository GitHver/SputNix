{pkgs, lib, config, ... }:

let
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
      package = pkgs.nordzy-icon-theme;
      name = "Nordzy";
    };
  };

  home.packages = gnomeExtensionsList;		# adds all extensions

  dconf.settings = {
  
    "org/gnome/shell".enabled-extensions =	# and then enables them here
      (map (extension: extension.extensionUuid) gnomeExtensionsList)
      ++ [
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        #"system-monitor@gnome-shell-extensions.gcampax.github.com"
      ];

    "org/gnome/desktop/interface" = {
      enable-hot-corners = false;
      color-scheme = "prefer-dark" ;
      ## Clock
      clock-show-weekday = true;
      clock-show-date = true;
      ## Font stuff
      monospace-font-name = "RobotoMono Nerd Font 10";
      font-antialiasing = "rgba";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,close";
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Shift><Super>s" ];
    };

  # ==== Dash to Dock ======================================================== #
    "org/gnome/shell/extensions/dash-to-dock" = {
    # == Transparency ================ #
      transparency-mode = "FIXED";
      background-opacity = 0.0;
    # == Dash action ================= #
      click-action  = "launch";
      scroll-action = "cycle-windows";
    # == Other ======================= #
      dock-position = "RIGHT";
      dock-fixed = true;
      extend-height = true;
      dash-max-icon-size = 38;
      show-trash = false;
      custom-theme-shrink = true;
    };

  # ==== Blur my shell ======================================================= #
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

  # ==== PaperWM ============================================================= #
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      show-window-position-bar = false;
      window-gap = 12;
      selection-border-size = 5;
      selection-border-radius-top    = 12;
      selection-border-radius-bottom = 12;
      vertical-margin        = 5;
      vertical-margin-bottom = 5;
      horizontal-margin = 10;
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
    # == Navigation ================== #
      # Move between windows
      switch-left  			= [ "<Super>h" ];
      switch-right 			= [ "<Super>l" ];
      switch-down  			= [ "<Super>j" ];
      switch-up    			= [ "<Super>k" ];
      # Rearange windows
      move-left    			= [ "<Control><Super>h" ];
      move-right   			= [ "<Control><Super>l" ];
      move-down    			= [ "<Control><Super>j" ];
      move-up      			= [ "<Control><Super>k" ];
      # Move between workspaces
      switch-down-workspace 		= [ "<Alt><Super>j" ];
      switch-up-workspace   		= [ "<Alt><Super>k" ];
      # Move between monitors
      switch-monitor-left   		= [ "<Alt><Super>h" ];
      switch-monitor-right  		= [ "<Alt><Super>l" ];
      # Move window between monitors
      move-monitor-left     		= [ "<Control><Alt><Super>h" ];
      move-monitor-right    		= [ "<Control><Alt><Super>l" ];
    # == Actions ===================== #
      # Common rules
      new-window   			= [ "<Super>c" ];
      close-window 			= [ "<Super>x" ];
      take-window  			= [ "<Super>z" ];
      # Misc
      center-horizontally         	= [ "<Super>b" ];
      switch-open-window-position 	= [ "<Super>w" ];
      switch-focus-mode           	= [ "<Super>e" ];
    };


  };

}
