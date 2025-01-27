
# Inputs possible because of the specialArgs line in flake.nix forwarding inputs:
{ pkgs, config, lib, inputs, variables, ... }: with lib; {

  imports = [
    # Modularize your home.nix by moving statements into other files
    ];

  home.username = "${variables.username}";
  home.homeDirectory = "/home/${variables.username}"

  home.stateVersion = "24.11";    # Don't change this. This will not upgrade your home-manager.
  programs.home-manager.enable = true;



  users.mutableUsers = false;   # Users and passwords cannot be changed ourside of this file.
  home.homeDirectory = "/home/${user}/YoinkOS/modules/";

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
    };



  home.packages = with pkgs; ([
    # Common packages
    hello
    protonup
    ]);

  home.programs = {
    bash.enable = true;
    };
}