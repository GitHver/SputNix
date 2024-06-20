{ config, pkgs, lib, inputs, outputs, ... }:

let
  hostname = import ./unique/hostname.nix;
  username = import ./unique/username.nix;
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
    firefox
    thunderbird  
    tor-browser
    webcord         # no telemetry discord
    signal-desktop

  # ==== Creativity ================== #
    obsidian  # or logseq
    #obs-studio 
    #blender

  # ==== Terminal utils ============== #
    zellij  # or tmux
    helix   # or neovim
    
  # ==== Misc ======================== #
    gnome.dconf-editor

  ];

# ====== Shell configuration ================================================= #
  programs = { # Only one can be active at a time
    bash.enable = true;
    #zsh.enable  = true;
    #fish.enable = true;
  };

  home.shellAliases = {
    rebuild-s = "sudo nixos-rebuild switch --flake ~/NixSystem#default";
    rebuild-h = "home-manager switch --flake ~/NixUser#${username}@${hostname}";
    update-s = "sudo nix flake update ~/NixSystem";
    update-h = "nix flake update ~/NixUser";
    clean = "nix-collect-garbage --delete-older-than 1d";
  };

# ====== Set user variables ================================================== #
  home.sessionVariables = {
    EDITOR = "hx";
  };

# ====== Manage home files =================================================== #
  home.file = {
  };

}
