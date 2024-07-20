{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vasu";
  home.homeDirectory = "/home/vasu";
  home.stateVersion = "24.05"; # Please read the comment before changing.

 # imports = [
 #   ../../config/hyprland.nix
 # ]

  home.packages = [
    pkgs.hello

  ];

  home.file.".config/hypr" = {
    source = ../../dots/hypr;
    recursive = true;
  };

  home.file.".config/nvim" = {
    source = ../../dots/nvim;
    recursive = true;
  };

  home.file.".config/kitty" = {
    source = ../../dots/kitty;
    recursive = true;
  };


  home.file.".gitconfig" = {
    source = ../../dots/.gitconfig;
  };



  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs = {
    home-manager = {
      enable = true;
    };
    kitty = {
      enable = true;
      package = pkgs.kitty;
    };
  };
}
