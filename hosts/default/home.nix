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
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 4;
        confirm_os_window_close = 0;
      };
      extraConfig = ''
        tab_bar_style fade
        tab_fade 1
        active_tab_font_style   bold
        inactive_tab_font_style bold
      '';
    };
  };
}
