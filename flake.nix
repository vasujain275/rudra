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
    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };
  };

  # Add nixCats after nixpkgs whenever it is needed
  outputs = {
    self,
    nixpkgs,
    nixCats,
    # ghostty,
    ...
  } @ inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
