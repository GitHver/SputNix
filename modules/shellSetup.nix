{ pkgs
, host
, ...
}:

{

  environment.shellAliases = {
    #====<< SSH Key Setup >>==============================================>
    ssh-perms = /*sh*/ ''
      chmod 644 ~/.ssh/config
      chmod 644 ~/.ssh/known_hosts.old
      chmod 644 ~/.ssh/id_ed25519.pub
      chmod 600 ~/.ssh/known_hosts
      chmod 600 ~/.ssh/id_ed25519
      ssh-agent -s
      ssh-add ~/.ssh/id_ed25519
    '';
    ssh-keygen-setup = /*sh*/ ''
      echo '
      copy the following and replace it with your email and then run it
        ssh-keygen -t ed25519 -C "your@email.domain"
      after that run:
        ssh-setup
      '
    '';
    ssh-setup = /*sh*/ ''
      echo '
      Host *
        AddKeysToAgent yes
        IdentityFile ~/.ssh/id_ed25519
      ' > ~/.ssh/config

      eval $(ssh-agent -s)
      ssh-add ~/.ssh/id_ed25519
      echo "This is your public key:"
      cat ~/.ssh/id_ed25519.pub
    '';
    #====<< Other >>===========================================================>
    flathub-add = /*sh*/ ''
      flatpak remote-add --user flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"
    '';
  };

}
