{
  description = "Rudra flake";
  inputs = {
    # nixpkgs: The main repository of Nix packages
    # Using nixos-unstable branch for latest stable packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # stylix: A theming framework for NixOS
    stylix.url = "github:danth/stylix";

    # home-manager: User environment management
    # The `follows` line means it will use the same nixpkgs as your main system
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixCats: Neovim for NixOS with Lazy properly configured
    nixCats = {
      url = "path:/home/vasu/rudra/modules/nixCats";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };
  };

  outputs = {
    self,
    nixpkgs,
    nixCats,
    hyprpanel,
    # ghostty,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    # Define your NixOS system configuration
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      # Pass the system architecture
      inherit system;

      # specialArgs makes these values available in your configuration modules
      specialArgs = {
        inherit inputs;
      };

      # The modules that make up your system configuration
      modules = [
        # Add this module to configure nixpkgs and overlays globally
        ({
          config,
          pkgs,
          ...
        }: {
          # Enable unfree packages globally
          nixpkgs.config.allowUnfree = true;

          # Configure the hyprpanel overlay
          nixpkgs.overlays = [
            hyprpanel.overlay
          ];
        })

        # Your main configuration file
        ./hosts/default/configuration.nix

        # Stylix module for system-wide theming
        inputs.stylix.nixosModules.stylix

        # Home-manager module for user environment management
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
