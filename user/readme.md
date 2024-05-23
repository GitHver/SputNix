# Installation of Home manager

this is bootstraping homanager to the system, once it's done, home manager will manage itself. to istall home manager, paste the following commands into the terminal:

` $ sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager `

` $ sudo nix-channel --update `

you might need to log out and in again if the below command does not work. restarting might also be needed.

` $ nix-shell '<home-manager>' -A install `

and now it is done! you can now use home-manager as a sudo-less installation of Nixpkgs, or to declare you home directory and manage you dotfiles. to build home-manager, use: 

` $ home-manager $action --flake /path/to/your/flake#username@hostname `

where '$action' is usually 'build' or 'switch', and the path '~/name-of-your-folder'
if you have everything in a folder in your home directory.

# Flatpaks

Flatpaks are packages entirely contained within them selves, perfect for an immutable system like nixos. the software app also manages updates and isntallations for these programs with a graphical user interface making it perfect fro the computer illiterate.

` services.flatpak.enable = true; `

this is already in your cofiguration.nix. to get access to the flathub repository you can run the command below.

` $ flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo `

it is recommended to install steam through flathub in order to avoid firewall permission tweaking in the nixos configuration
