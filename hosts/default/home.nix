{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vasu";
  home.homeDirectory = "/home/vasu";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../config/waybar.nix
    # ../../config/wlogout.nix
  ];

  # Styling
  stylix.targets.waybar.enable = false;
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  # qt = {
  #   enable = true;
  #   style.name = "adwaita-dark";
  #   platformTheme.name = "gtk3";
  # };
  #
  # home.sessionVariables = {
  #   # EDITOR = "emacs";
  # };
  #
  programs = {
    home-manager = {
      enable = true;
    };
    kitty = {
      enable = true;
      package = pkgs.kitty;
      extraConfig = ''
        font_size 22.0
        window_margin_width 2
        sync_to_monitor yes
        term xterm-256color
        background_opacity 0.80
      '';
    };
  };
}
