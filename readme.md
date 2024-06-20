#### Table of contents
1. [Overview](#overview)
**--Instructions**
2. [Flashing the USB](#flashing-a-usb)
3. [Booting from a live cd](#booting-from-a-live+cd)
4. [Bootstrapping flakes](#bootstrapping-flakes)
5. [Configuration](#configuration)
6. [Final steps](#final-steps)
7. [Continued usage](#continued-usage)

# Overview

SputNix is a newbie ready flake for NixOS. The goal is to make a configuration that works out of the box, while also teaching the user how to navigate their system. if you want to learn more about NixOS, you can go to https://nixos.org/explore/ and see if NixOS is for you!

# Instructions

#### Flashing a USB

The first thing you'll need is a USB thumb drive. Go to https://nixos.org/download/ and scroll down to *NixOS: the Linux distribution* and click on the `download (Gnome, 64-bit intel/AMD)` button. When it is finished, verify the integrity of the image with sha256.

Now you need to flash the ISO image to the USB drive. You can use either [Etcher](https://etcher.balena.io/) or [Ventoy](https://www.ventoy.net/en/index.html). I recommend Ventoy, as you can have multiple ISO images on it while also storing files. This way you can download both a NixOS ISO and a Windows ISO, so if you want go back or something goes wrong, you can just boot back into Windows with out needing a second computer to redownload and flash the ISO. You can even jump to the [Configuration](#configuration) section and pre configure your system and store it on the Ventoy drive.

#### Booting from a live CD

To boot from the ISO on the USB, you need to restart/turn on your computer, and hit either: F2, F12, DEL or F10. A splash screen image might say which one you need to press. With that you should be but into BIOS or UEFI interface.

there is no standard interface, so you'll have to navigate the menus yourself. But the things you need to make sure are true is firstly to disable secure boot, as it has nothing to do with security or safety. Then move the USB to the top of the boot priority and then hit F10 to Save and exit the BIOS/UEFI environment.

you should then be greeted by a live environment of NIxOS Gnome. The calamari installer should launch automatically. simply follow the instructions it provides and wait for the install to complete. Be sure to chose Gnome as your desktop environment, as this guide assumes that you are using Gnome.

*note: the installer will "get stuck" at 46%. this is because there are 11 steps in the installation process, and the fifth one takes by far the longest, so don't worry!. 5/11 = 46%*

Once the installation is complete, restart the system and you should boot up on the drive you installed it on, so it is safe to unplug the USB drive.

#### Bootstrapping flakes

Once you're in your new NixOS system, you should open the terminal. it should be called "Console" and be in the utilities folder in the applications view. To access the applications view,double press the Super key (windows key) or Super-a. you can also press the super key once and search for it by typing "console". Now you can start following the instructions below.

*note: you do not actually need to use the terminal to do most of the below, but getting used to the terminal will help you a lot when using Linux. It is scary at first, but once you use it for more than 10 minutes, I think you'll find realise why the terminal is still so prevalent on Linux systems, and that it is nothing like CMD on windows, but a fully functional computer interfacing environment. Even if you don't feel comfortable, you'll "only" need to use it in the boot-strapping process*

Begin by copying the auto-generated hardware config file in /ect/nixos to the template computer directory by typing or pasting the following command into the terminal:

`$ sudo cp /etc/nixos/hardware-configuration.nix s~/SputNix-1/archive/template`

*note: to paste into the terminal, you need to also hold shift. e.x:
copy = shift-ctrl-c
paste = shift-ctrl-v*

Now that you have your computers hardware scan in the SputNix directory, you now need to bootstrap the flake features to be able to rebuild your system from the 

`$ sudo nano /etc/nixos/configuration.nix` or
`$ sudo gnome-text-editor /etc/nixos/configuration.nix`

paste the following in a new line anywhere below the curly bracket scope:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

and in environment.systemPackages, put the following, so that it looks like this:

```nix
environment.systemPackages = with pkgs; [
  micro
  lf
  wl-clipboard
];
```

*Note: Micro is a terminal text editor that is way superior to nano, it uses common keybinds like (shift)"ctrl-c" and "ctrl-v" to copy and paste like any other program. You can also use helix or vim or VScodium if you want to, but Micro is simple and elegant in is worth learning.*

ctrl-s to save and then close the program. then put the following in the terminal:

`sudo nixos-rebuld switch`

And now you have access to flakes!

#### Configuration

now you can use what ever text editor you chose to do the last editing steps to a complete system configuration. The fields that need some changing are:

**Hostname:**
This is just the name of your computer. if you have for example a Lenovo yoga slim 7, then your hostname could be "slim7". your terminal will then display: `[user@slim7:~]$`
Once you have decided on a hostname, open ~/Sputnix/archive/template/hostname.nix and replace the field with your desired hostname, then rename the template directory to the hostname and finally copy hostname.nix into ~/SputNix/. (the top directory).

**Username:**
Your username. The user field looks like this:
```nix
# ====== User management =============================================== #
  users.mutableUsers = true;             # Makes the home directory writeable.
  users.users = {                        # See *Users* for more info
    "your-user-directory-name" = {         # example: "john-smith"
    description  = "Your Display Name";    # example: "John Smith"
    isNormalUser = true;
    extragroups = [ "wheel" "networkmanager" ];
    };
  };
```
"your-user-directory-name" ***NEEDS*** to be the same as your current user directory (that is /home/"the-name"). Else the rebuild will create a whole new user and delete the current one. The name you want to be displayed goes in the description 

**Localization:**
Sets the language and keymap for your system. Open the configuration file in /etc/nixos and copy the appropriate settings to this place:
```nix
# ====== Localization ================================================== #
  time.timeZone = "Europe/London";
  locale-all = "en_GB.UTF-8";       # default is "en_GB.UTF-8".
  console.keyMap = "uk";            # Sets the console keymap.
  services.xserver.xkb = {          # Set the keymap for Xserver.
    layout = "gb";
    variant = "";
  };
```
The huge .UTF-8 block that is generated has been moved to a module and is controlled by the "locale-all". Just put your locale, e.x "is_IS.UTF-8", as the value and it will be applied to everything. See more by opening localization.nix in the modules directory

**Packages:**
Set any system packages you want on your system here. for example: nerdfonts, wget, python, rust, etc. all can be found on [The Nix package repository](https://search.nixos.org/packages)

**Steam an other special programs:**
Some programs require extra permissions to use fully. Steam needs firewall premissions to use online peer hosting functionalities like remoteplay and server hosting. Davinci resolve currently needs sudo privileges to even launch, so it needs to be installed system wide.

#### Final steps

now, assuming that you have set up all the necessary configuration into the config file, you can type the following into your terminal:

`$ sudo nixos-rebuild switch --flake ~/SputNix-1`

This will rebuild your system according to your specification in the configuration file

#### Continued usage

This is all you need for a complete working system, but you need to learn to use it properly form you to gain any of the benefits of Nix.

***Version control***

It is recommended to use some form of version control to manage your configuration files as even though you can roll back to any version of your system, the configuration file stays the same. so you would have to remember your changes for each version. I recommend using git, but you can just as easily copy the files each time and store it on a USB drive.

***Commands***

Some common commands you'll need to know are:

- `sudo nixos-rebuild`
  - with: `switch`, `test`, `build`
  - and:  `--flake /path/to/the/flake`
  - example: `sudo nixos-rebuild switch --flake ~/SputNix-1`

- `nix flake update`
  - with `/path/to/the/flake`
  - example: `nix flake update ~/SputNix-1`

- `nix-collect-garbage`
  - with: `-d`, `-delete-older-than`
  - and: `3d` 3days, `5m` 5months, `2w` 2weeks
  - example: `nix-collect-garbage --delete-older-than 10d`

***Home-manager***

Home manager is a way to manage your home directory and user packages using Nix. It has tons of useful options to decoratively manage users, but currently does not support automatic rollbacks. You of course can, but you'll have to manually switch profiles. But It also doesn't need sudo to make changes, so it's not like you can break your system with it. This is extremely useful for system admins who want to make users manage themselves with out admin privileges. it can also be used on other distros and even on macs. But for non power users and those who are the only users on their machine, home manager has less to offer.

I already have a guide on how to get home manager up and running that is compatible with this guide, but I am tweaking it to work well with declarative multi user installations and it's almost done, but for many people, this is all you need.
