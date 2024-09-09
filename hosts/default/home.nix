{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vasu";
  home.homeDirectory = "/home/vasu";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ../../config/rofi/rofi.nix
    ../../config/wlogout.nix
  ];
  
  home.file.".config/wlogout/icons" = {
  source = ../../config/wlogout;
  recursive = true;
  };
  
  # Set environment variables

  home.sessionVariables = {

    EDITOR = "nixCats";
    VISUAL = "nixCats";
    TERMINAL = "kitty";
    BROWSER = "firefox";

    # XDG variables
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/screenshots";

    # Other variables
    JAVA_AWT_WM_NONREPARENTING = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";

    # Localization
    LC_ALL = "en_US.UTF-8";
  };


  # Add custom paths to PATH

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/go/bin"
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
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };

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

  # programs.neovim = {
  #     plugins = with pkgs.vimPlugins; [
  #       nvim-treesitter.withAllGrammars
  #       (nvim-treesitter.withPlugins (p: [
  #         p.json
  #         p.javascript
  #         p.typescript
  #         p.tsx
  #         p.yaml
  #         p.html
  #         p.css
  #         p.prisma
  #         p.markdown
  #         p.markdown-inline
  #         p.svelte
  #         p.graphql
  #         p.bash
  #         p.lua
  #         p.vim
  #         p.dockerfile
  #         p.gitignore
  #         p.query
  #         p.vimdoc
  #         p.c
  #       ]))
  #     ];
  # };

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
  #   # EDITOR = "nvim";
  # };
  #
  programs = {
    home-manager = {
      enable = true;
    };
  };
}
