{
  inputs = {
    # All packages should follow latest nixpkgs/nur
    nixpkgs.url = "nixpkgs/nixos-22.11";
    # Nix-Darwin
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NixOS Hardware for extra config
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    # HM-manager for dotfile/user management
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Bar (macos)
    spacebar = {
      url = "github:shaunsingh/spacebar";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs: {
    # Sad day - Anduril IT picks your hostname for you.
    darwinConfigurations."NCROCKER-MACBOOK14" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./modules/mac.nix
        home-manager.darwinModule
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ncrocker = {
              imports = [
                ./modules/home.nix
              ];
            };
          };
        }
        ({ config, pkgs, lib, ... }: {
          services.nix-daemon.enable = true;
          nixpkgs = {
            overlays = with inputs; [
              spacebar.overlay
            ];
            config.allowUnfree = true;
          };
          environment.shells = [ pkgs.zsh ];

          # not sure why I have to set this. I do it in modules/home.nix, but it's not happy
          programs.zsh.enable = true;
        })
      ];
    };
  };
}
