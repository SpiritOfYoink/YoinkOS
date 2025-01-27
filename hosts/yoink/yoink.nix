# Master list of all variables:

even went one step further and moved all the variables from flake.nix to the folder
./hosts/HOSTNAME/settings.nix and imported them into this specialArgs with "settings = import ./hosts/HOSTNAME/settings.nix;".
This means I can make settings per host and manage multiple hosts at the same time in one flake.


variables attribute set {


}