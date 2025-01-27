
{ config, pkgs, lib, variables, ... }:
let

in {

  imports = [
    ## Modularize your home.nix by moving statements into other files
    ];

  home.username = "${variables.username}";
  home.homeDirectory = "/home/${variables.username}"

  home.stateVersion = "23.05"; # Don't change this. This will not upgrade your home-manager.
  programs.home-manager.enable = true;

  home.packages = with pkgs; ([
    # Common packages
    hello
    ]);
}