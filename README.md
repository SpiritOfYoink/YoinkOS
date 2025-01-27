# YoinkOS

An attempt to build a modular, multi-user NixOS config, using Niri.

# TO INSTALL:

* Step 1: Install NixOS using a graphical installer.
  * For name and username, select from: yoink, dame, mac, & hamster. Selecting one of these four is required for the installation to proceed automatically.
  * Choose a temporary password, and check both 'login automatically,' and 'reuse password for administrator.'
  * Select 'no desktop' when prompted.
  * Finally, partition the hard drive you're installing NixOS to, selecting the 'swap but no hibernate' option.


* Step 2: Reboot, removing the installation media.


* Step 3: In the terminal prompt you're presented with, run the following:
 
    ``` nix-shell -p git --command "nix run github://spiritofyoink/yoinkos --extra-experimental-features nix-command --extra-experimental-features flakes ```

* Step 4: After installation, the computer will reboot. You should now be in NixOS.