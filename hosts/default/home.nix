{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vasu";
  home.homeDirectory = "/home/vasu";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../config/waybar.nix
    ../../config/rofi/rofi.nix
    ../../config/wlogout.nix
    # ../../config/neovim.nix
  ];
  
  home.file.".config/wlogout/icons" = {
  source = ../../config/wlogout;
  recursive = true;
  };


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

  home.packages = [
    # (import ../../scripts/emopicker9000.nix { inherit pkgs; })
    # (import ../../scripts/task-waybar.nix { inherit pkgs; })
    # (import ../../scripts/squirtle.nix { inherit pkgs; })
    # (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
    # (import ../../scripts/wallsetter.nix {
    #   inherit pkgs;
    #   # inherit username;
    # })
    # (import ../../scripts/web-search.nix { inherit pkgs; })
    (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
    # (import ../../scripts/screenshootin.nix { inherit pkgs; })
    # (import ../../scripts/list-hypr-bindings.nix {
    #   inherit pkgs;
    #   inherit host;
    # })
  ];

  programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        (nvim-treesitter.withPlugins (p: [
          p.json
          p.javascript
          p.typescript
          p.tsx
          p.yaml
          p.html
          p.css
          p.prisma
          p.markdown
          p.markdown-inline
          p.svelte
          p.graphql
          p.bash
          p.lua
          p.vim
          p.dockerfile
          p.gitignore
          p.query
          p.vimdoc
          p.c
        ]))
      ];
  };

  services = {
    hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };



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
