
#### Description



# Installation

There are two ways you can install home manager. 

The first way imports it through the flake.nix in the system flake. This unifies the system and home configurations allowing you to use the home manager options. This becomes a problem with more than one user as all users would need to have access to sudo privileges to make any changes.

The other way is to use the stand-alone installation. With this each user can manage their own $HOME without sudo. This also removes all user settings away from the system config.

#### Module

*TBA*

#### Stand-alone

This is bootstrapping home manager to the system, once it's done, home manager will manage itself

` nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager `

` nix-channel --update `

You might need to log out and in again if the below command does not work. Restarting might also be needed.

` nix-shell '<home-manager>' -A install `

And now it is done! you can now use home-manager as a sudo-less installation of Nixpkgs, or to declare you home directory and manage you dotfiles.

#### Usage

To build home-manager, use:

` home-manager switch --flake ~/SputNix-1/user#username `

Where the path is ~/name-of-folder if you have everything in a folder in your home directory.

Open home.nix to start declaring your home directory. I have put a modified version of gnome using paperWM in the gnome-defaults.nix that you can use as a base.
