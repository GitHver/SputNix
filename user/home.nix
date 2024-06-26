{ pkgs, ... }: 

let
  username = "your-userdirectory;
  hometype = "Module"; #or "Standalone"
in
{ # ==== Variable scope ====================================================== #

  imports = [
    ./modules/gnome-defaults.nix
  ];

# ====== Home manager settings =============================================== #
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

# ====== Other settings ====================================================== #
  fonts.fontconfig.enable = true;

# ====== User Packages ======================================================= #
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
  
  # ==== Internet ==================== #
    firefox         # Fiwefwox! or
    #librewolf       # Pre hardened Firefox or
    #floorp          # A beautiful Firefox Fork
    thunderbird     # FOSS email client.
    #tor-browser     # Anonymous web browser.
    #qbittorrent     # BitTorrent client
    #signal-desktop  # Private messages.
    #webcord         # No telemetry discord  .

  # ==== Creativity ================== #
    #obsidian        # Markdown file editor, or
    #logseq          # A FOSS alternative.
    #obs-studio      # Recording software.
    #davinci-resolve # Exeptional video editing software
    #blender         # 3D rendering software.
    #libre-office    # FOSS office suite.

  # ==== Media ======================= #
    vlc             # Multi media player
    #spotify         # Music streaming service

  # ==== Terminal utils ============== #
    zellij          # User friendly terminal multiplexer, or
    #tmux            # A More known alternative,
    helix           # No nonsense terminal modal text editor, or
    #neovim          # A bigger ecosystem with plugins.
    yazi

  # ==== Fonts ======================= #
    (nerdfonts.override { fonts = [
      "CascadiaCode"
    ]; })
    
  # ==== Misc ======================== #
    wineWowPackages.stable  # Windows executable translator
    #wineWowPackages.unstable.override { waylandSupport = true; }
    #minecraft              # Minecraft
  ];

 #====== Default 

# ====== Shell configuration ================================================= #
  programs = { # Only one can be active at a time
    bash.enable = true;
    #zsh.enable  = true;
    #fish.enable = true;
  };

  home.shellAliases = {
    rebuild-s = "sudo nixos-rebuild switch --flake ~/SputNix-1#${hometype}";
    rebuild-h = "home-manager switch --flake ~/SputNix-1/user#${username}";
    update-s = "sudo nix flake update ~/SputNix-1";
    update-h = "nix flake update ~/SputNix-1/user";
    upgrade  = ''
      sudo nix flake update ~/SputNix-1
      sudo nixos-rebuild switch --flake ~/SputNix-1${hometype}
      nix flake update ~/SputNix-1/user
      home-manager switch --flake ~/SputNix-1/user#${username}
      '';
    clean = "sudo nix-collect-garbage --delete-older-than 1d";
  };

# ====== Set user variables ================================================== #

  home.sessionVariables = {
    TERMINAL     = "wezterm";
    EDITOR       = "hx"; # change to nvim or equivalent
    FILE_MANAGER = "yazi";
    LAUNCHER     = "rofi";
    #ANY_VARIBLE = "VALUE";
  };

# ====== Manage home files =================================================== #
  home.file = {
    ".config" = {
      source = ./dotfiles;
      recursive = true;
    };
  };
}
