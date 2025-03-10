{ pkgs, lib, config, inputs, ... }:

let
  inherit (lib) mkDefault;
in { config = {

  #====<< System Services >>===================================================>
  services = {
    # The COSMIC desktop environment. Wayland based & Rust made.
    cosmic.enable = true;
    cosmic.greeter.enable = true;
    # Printer protocols. Enable for support.
    printing.enable = false;
  };

  #====<< System packages >>===================================================>
  # If you want to use flatpaks for some reason, all you have to do is set the
  # option below to true and run the command: `flathub-add`.
  services.flatpak.enable = false;
  # Here you can decide if you to allow non open source packages to be installed
  # on your system. You should try to disable this and see what it says!
  nixpkgs.config.allowUnfree = mkDefault false;
  # Below is where all the sytem-wide packages are installed.
  # Go to https://search.nixos.org/packages to search for packages.
  environment.systemPackages = (with pkgs; [
    sputnix.home-manager-setup
    wl-clipboard
    # some-package
  ]);

  #====<< Localization & internationalization >>===============================>
  localization = {
    # i18n locale. You can find available locales with `locale -a`.
    language   = "language-locale";
    formatting = "formatting-locale";
    # Your time zone. See all available with `timedatectl list-timezones`.
    timezone   = "Europe/London";
  };

  #====<< Keyboard >>==========================================================>
  console.useXkbConfig = true;  # Makes the virtual terminal use the xkb config.
  services.xserver.xkb = {
    layout  = "gb";           # Set the language keymap for XKeyboard.
    # variant = "";             # Any special layout you use like colemak, dvorak.
    # model   = "pc104";        # The keyboard model. default is 104 key.
    # options = "caps:escape";  # Here, Capslock is an additional escape key. 
  };

  #====<< Nix specific settings >>=============================================>
  # Settings for the Nix package manager.
  nix = {
    # What version of the Nix package manager to use.
    package = pkgs.nix;
    # Automatically delete old & unused packages
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    # Here are the settings that get put into `/etc/nix/nix.conf`.
    settings = {
      # Replaces identical files with links to save space. works the same as:
      # `nix store optimise`
      auto-optimise-store = true;
      # Access rights to the Nix deamon. This is a list of users, but you can
      # specify groups by prefixing an entry with `@`. `*` is everyone.
      allowed-users = [ "nixers" ];
      trusted-users = [ "root" "@wheel" ];
      # These are features needed for flakes to work. You can find more at:
      # https://nix.dev/manual/nix/2.24/development/experimental-features
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
        # "recursive-nix"
        # "dynamic-derivations"
      ];
    };
  };

  #====<< Miscellaneous >>=====================================================>
  # What version of NixOS configs to use.
  system.stateVersion = "25.05";
  # Removes the NixOS manual application.
  documentation.nixos.enable = false;
  # Nix ld is one solution to the static binary problem. This only affects you
  # if you need to run random binaries from sources other than nixpkgs. Learn
  # more here: https://github.com/nix-community/nix-ld
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = (with pkgs; [ ]);

};} ###################### End of config scope. ################################
