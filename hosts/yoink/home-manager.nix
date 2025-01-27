
{ config, pkgs, lib, ... }:
let

in {

  imports = [
    ## Modularize your home.nix by moving statements into other files
    ];

  home.username = "yoink";
  home.homeDirectory = "/home/your-username"

  home.stateVersion = "23.05"; # Don't change this. This will not upgrade your home-manager.
  programs.home-manager.enable = true;

  home.packages = with pkgs; ([
    # Common packages
    hello
  ] ++ lib.optionals isLinux [
    # GNU/Linux packages
  ]
  ++ lib.optionals isDarwin [
    # macOS packages
  ]);
}