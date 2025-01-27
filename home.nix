
{ config, pkgs, lib, variables... }:
let

in {

  imports = [
    # Modularize your home.nix by moving statements into other files
    ];

  home.username = "${variables.user}";
  home.homeDirectory = "/home/${variables.user}"

  home.stateVersion = "24.11";    # Don't change this. This will not upgrade your home-manager.
  programs.home-manager.enable = true;    # Allows home manager to run.

  home.packages = with pkgs; ([
    # Common packages
    hello
    
  ] );
}   # End of file.