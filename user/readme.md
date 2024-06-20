# list of commands

this is bootstraping homanager to the system, once it's done, home manager will manage itself

` $ sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager `

` $ sudo nix-channel --update `

you might need to log out and in again if the below command does not work. restarting might also be needed.

` nix-shell '<home-manager>' -A install `

and now it is done! you can now use home-manager as a sudo-less installation of Nixpkgs, or to declare you home directory and manage you dotfiles. to build home-manager, use: 

` home-manager $action --flake /path/to/your/flake#username@hostname `

where $action is usually 'build' or 'switch', and the path ~/name-of-folder
if you have everything in a folder in your home directory.
