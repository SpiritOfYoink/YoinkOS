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
    outputs = { self, pkgs, lib, variables, ... }@inputs:

    let   # pkgs doesn't get imported.
      pkgs-stable = import nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
        };
    in {

      perInput = system: flake:
      # Include vscode extensions in inputs'
        nixpkgs.lib.optionalAttrs (flake ? extensions.${system}) {
          extensions = flake.extensions.${system};
        };




      nixosConfigurations = {
        # My Lenovo 50-70y laptop with nvidia 860M
        NixToks = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-stable;
          };

          modules = [ ./hosts/NixToks ];
        };
        # My Acer Swift Go 14 with ryzen 7640U
        NixPort = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-stable;
          };

          modules = [ ./hosts/NixPort ];
        };
        # NixOS WSL setup
        NixwsL = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-stable;
          };

          modules = [ ./hosts/NixwsL ];
        };
        # Nix VM for testing major config changes
        NixVM = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-stable;
          };

          modules = [ ./hosts/NixVM ];
        };
      };
      # My android phone/tablet for Termux
      nixOnDroidConfigurations = {
        NixMux = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          extraSpecialArgs = {
            inherit inputs;
          };
          pkgs = import nixpkgs {
            system = "aarch64-linux";

            config.allowUnfree = true;
          };

          modules = [ ./hosts/NixMux ];
        };
      };
    };
}