{ pkgs, ... }: 

let
  username = import ./username.nix;
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

# ====== User Packages ======================================================= #
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
  
  # ==== Internet ==================== #
    firefox         # Fiwefwox! or
    #librewolf      # Pre hardened Firefox
    thunderbird     # FOSS email client.
    tor-browser     # Anonymous web browser.
    signal-desktop  # Private messages.
    #webcord        # No telemetry discord  .

  # ==== Creativity ================== #
    obsidian      # Markdown file editor, or
    #logseq       # A FOSS alternative.
    #obs-studio   # Recording software.
    #blender      # 3D modeling and rendering software.
    #libre-office # FOSS office suite.

  # ==== Media ======================= #
    vlc       # Mediaplayer
    #spotify  # Music streaming service

  # ==== Terminal utils ============== #
    zellij    # User friendly terminal multiplexer, or
    #tmux     # A More known alternative,
    helix     # No nonsense terminal modal text editor, or
    #neovim   # A bigger ecosystem with plugins.
    
  # ==== Misc ======================== #
    gnome.dconf-editor  # GUI for dconf
    #minecraft          # Minecraft
  ];

# ====== Shell configuration ================================================= #
  programs = { # Only one can be active at a time
    bash.enable = true;
    #zsh.enable  = true;
    #fish.enable = true;
  };

  home.shellAliases = {
    rebuild-s = "sudo nixos-rebuild switch --flake ~/SputNix-1#default";
    rebuild-h = "home-manager switch --flake ~/SputNix-1/user#${username}";
    update-s = "sudo nix flake update ~/SputNix-1";
    update-h = "nix flake update ~/SputNix-1/user";
    clean = "nix-collect-garbage --delete-older-than 1d";
  };

# ====== Set user variables ================================================== #
  home.sessionVariables = {
    EDITOR = "hx"; # change to nvim or equivalent
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
