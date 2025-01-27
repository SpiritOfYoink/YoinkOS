{
    description = "Yoink's Modular Configuration";
      nixConfig.extra-substituters = "https://niri.cachix.org";   # Uses the niri cache, to avoid recompiling every build.
      nixConfig.extra-trusted-public-keys = '' niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964= '';   # Necessary for the above.

#   ..... INPUTS .....
    inputs = {
    # Nixpkgs - tools to build all the rest.
      nixos.url = "github:nixos/nixpkgs/nixos-unstable";
      nixpkgs.follows = "nixos";
      nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";
      nixos-hardware.url = "github:nixos/nixos-hardware";

    # Home-manager - declarative .config files.
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        };

    # Niri - window manager
      niri-flake.url = "github:sodiboo/niri-flake";

    # Allows Niri to use xwayland for running x applications
      xwayland-satellite-stable.url = "github:Supreeeme/xwayland-satellite/v0.5";

    # Secrets
      sops-nix = {
        url = "github:Mic92/sops-nix";
        inputs.nixpkgs.follows = "nixpkgs";
        };

    # Ghostty - terminal
      ghostty.url = "github:ghostty-org/ghostty";

    # Stylix - system-wide theming
      stylix.url = "github:danth/stylix";

    # Minecraft launcher
      nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    };


#   ..... OUTPUTS .....
    outputs = { self, pkgs, lib, variables, home-manager, ... }@inputs:
    nixosConfigurations = {

      yoink = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          variables = {
            user = "yoink";
            description = "The Spirit of Yoink";
            networking-hostname = "Ncase M2" 
            server = "//192.168.1.70/NAS_Storage";    # Where's your network storage attached? (SMB share.)
            lib = nixpkgs.lib;
            github = "https://github.com/SpiritOfYoink/YoinkOS";
            }; };
        extraSpecialArgs = {
          inherit inputs;
          variables = {
            user = "yoink";
            description = "The Spirit of Yoink";
            networking-hostname = "Ncase M2" 
            server = "//192.168.1.70/NAS_Storage";    # Where's your network storage attached? (SMB share.)
            lib = nixpkgs.lib;
            github = "https://github.com/SpiritOfYoink/YoinkOS";
            }; };
        modules = [ ./hosts/yoink/yoink.nix ];
        mutableUsers = false;   # Users and passwords cannot be changed ourside of this file.
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          }; };

      dame = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          variables = {
            user = "dame";
            fullname = "No Aim Dame";
            server = "//";    # Fill this out when you build a NAS. (SMB share.)
            lib = nixpkgs.lib;
            github = "https://github.com/SpiritOfYoink/YoinkOS";
            }; };
         ExtraSpecialArgs = {
          inherit inputs;
          variables = {
            user = "dame";
            fullname = "No Aim Dame";
            server = "//";    # Fill this out when you build a NAS. (SMB share.)
            lib = nixpkgs.lib;
            github = "https://github.com/SpiritOfYoink/YoinkOS";
            }; };
        modules = [ ./hosts/dame/dame.nix ];
        mutableUsers = false;   # Users and passwords cannot be changed ourside of this file.
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
          }; };

}; }   # End of file.