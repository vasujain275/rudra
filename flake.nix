{
  description = "Rudra flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixCats = {
      url = "path:/home/vasu/rudra/modules/nixCats";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixCats,
      hyprpanel,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Define the custom SDDM theme as an overlay
      customSddmThemeOverlay = final: prev: {
        customSddmTheme = prev.stdenv.mkDerivation {
          name = "rose-pine";
          src = ./modules/sddm-theme;
          installPhase = ''
            mkdir -p $out/share/sddm/themes/rose-pine
            cp -r $src/* $out/share/sddm/themes/rose-pine
          '';
        };
      };

      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          (
            {
              config,
              pkgs,
              ...
            }:
            {
              nixpkgs.config.allowUnfree = true;

              # Add the custom theme overlay
              nixpkgs.overlays = [
                customSddmThemeOverlay
                hyprpanel.overlay
              ];
            }
          )
          ./hosts/default/configuration.nix
          inputs.stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.default
        ];
      };
    };
}
