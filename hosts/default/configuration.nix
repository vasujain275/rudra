{
  config,
  lib,
  pkgs,
  inputs,
  options,
  ...
}: let
  username = "vasu";
  userDescription = "Vasu Jain";
  homeDirectory = "/home/${username}";
  hostName = "rudra";
  timeZone = "Asia/Kolkata";
in {
  imports = [
    ./hardware-configuration.nix
    ./user.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    inputs.home-manager.nixosModules.default
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = ["v4l2loopback"];
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
    tmp = {
      useTmpfs = true;
      tmpfsSize = "30%";
    };
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = true;
  };

  networking = {
    hostName = hostName;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
    firewall = {
      allowedTCPPortRanges = [
        {
          from = 8060;
          to = 8090;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 8060;
          to = 8090;
        }
      ];
    };
  };

  time.timeZone = timeZone;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  stylix = {
    enable = true;
    base16Scheme = {
      base00 = "191724";
      base01 = "1f1d2e";
      base02 = "26233a";
      base03 = "6e6a86";
      base04 = "908caa";
      base05 = "e0def4";
      base06 = "e0def4";
      base07 = "524f67";
      base08 = "eb6f92";
      base09 = "f6c177";
      base0A = "ebbcba";
      base0B = "31748f";
      base0C = "9ccfd8";
      base0D = "c4a7e7";
      base0E = "f6c177";
      base0F = "524f67";
    };
    image = ../../config/assets/wall.png;
    polarity = "dark";
    opacity.terminal = 0.8;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      package = pkgs.nix-ld-rs;
    };
    firefox.enable = false;
    dconf.enable = true;
    fuse.userAllowOther = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  users = {
    mutableUsers = true;
    users.${username} = {
      isNormalUser = true;
      description = userDescription;
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        firefox
        thunderbird
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    # Text editors and IDEs
    nano
    vscode
    zed-editor
    jetbrains.idea-ultimate

    # Zen Browser from custom input
    inputs.zen-browser.packages."${system}".default

    # Programming languages and tools
    go
    lua
    python3
    python3Packages.pip
    uv
    clang
    zig
    rustup
    nodePackages_latest.pnpm
    nodePackages_latest.yarn
    nodePackages_latest.nodejs
    bun
    jdk
    maven
    gcc
    nodePackages_latest.live-server

    # Frappe Bench
    redis
    wkhtmltopdf
    nginx
    uv
    mariadb

    # Version control and development tools
    git
    gh
    lazygit
    lazydocker
    bruno
    gnumake
    coreutils
    nixfmt-rfc-style
    meson
    ninja

    # Shell and terminal utilities
    stow
    wget
    killall
    eza
    starship
    kitty
    zoxide
    fzf
    tmux
    progress
    tree
    alacritty
    exfatprogs

    inputs.nixCats.packages.${pkgs.system}.nvim
    inputs.ghostty.packages.${pkgs.system}.default

    # File management and archives
    yazi
    p7zip
    unzip
    unrar
    file-roller
    ncdu
    duf

    # System monitoring and management
    htop
    btop
    lm_sensors
    inxi
    auto-cpufreq
    nvtopPackages.nvidia
    anydesk

    # Network and internet tools
    aria2
    qbittorrent
    cloudflare-warp
    tailscale
    onedrive

    # Audio and video
    pulseaudio
    pavucontrol
    ffmpeg
    mpv
    deadbeef-with-plugins

    # Image and graphics
    imagemagick
    gimp
    hyprpicker
    swww
    hyprlock
    waypaper
    imv

    # Productivity and office
    obsidian
    onlyoffice-bin
    libreoffice-qt6-fresh
    spacedrive
    hugo

    # Communication and social
    telegram-desktop
    zoom-us
    vesktop
    element-desktop

    # Browsers
    firefox
    google-chrome

    # Gaming and entertainment
    stremio

    # System utilities
    libgcc
    bc
    kdePackages.dolphin
    lxqt.lxqt-policykit
    libnotify
    v4l-utils
    ydotool
    pciutils
    socat
    cowsay
    ripgrep
    lshw
    bat
    pkg-config
    brightnessctl
    virt-viewer
    swappy
    appimage-run
    yad
    playerctl
    nh
    ansible

    # Wayland specific
    hyprshot
    hypridle
    grim
    slurp
    waybar
    dunst
    wl-clipboard
    swaynotificationcenter

    # Virtualization
    libvirt

    # File systems
    ntfs3g
    os-prober

    # Downloaders
    yt-dlp
    localsend

    # Clipboard managers
    cliphist

    # Fun and customization
    cmatrix
    lolcat
    fastfetch
    onefetch
    microfetch

    # Networking
    networkmanagerapplet

    # Education
    # ciscoPacketTracer8
    wireshark
    ventoy

    # Music and streaming
    youtube-music
    spotify

    # Miscellaneous
    greetd.tuigreet
  ];

  fonts.packages = with pkgs; [
    noto-fonts-emoji
    fira-sans
    roboto
    noto-fonts-cjk-sans
    font-awesome
    material-icons
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal
    ];
  };

  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        };
      };
    };
    logind = {
      extraConfig = ''
        HandlePowerKey=suspend
      '';
    };
    cloudflare-warp.enable = true;
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    # ollama = {
    #   enable=true;
    #   acceleration = "cuda";
    # };
    cron = {
      enable = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    flatpak.enable = true;
    printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin];
    };
    auto-cpufreq.enable = true;
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    syncthing = {
      enable = true;
      user = username;
      dataDir = homeDirectory;
      configDir = "${homeDirectory}/.config/syncthing";
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };

  systemd.services = {
    onedrive = {
      description = "Onedrive Sync Service";
      after = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "simple";
        User = username;
        ExecStart = "${pkgs.onedrive}/bin/onedrive --monitor";
        Restart = "always";
        RestartSec = 10;
      };
    };
    flatpak-repo = {
      path = [pkgs.flatpak];
      script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
    };
  };

  hardware = {
    sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
      disabledDefaultBackends = ["escl"];
    };
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio.enable = false;
    graphics.enable = true;
  };

  services.blueman.enable = true;

  security = {
    rtkit.enable = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            )
          {
            return polkit.Result.YES;
          }
        })
      '';
    };
    pam.services.swaylock.text = "auth include login";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.hyprland.enable = true;

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Web browser related
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/chrome" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];
      "application/x-extension-htm" = ["firefox.desktop"];
      "application/x-extension-html" = ["firefox.desktop"];
      "application/x-extension-shtml" = ["firefox.desktop"];
      "application/x-extension-xht" = ["firefox.desktop"];
      "application/x-extension-xhtml" = ["firefox.desktop"];
      "application/xhtml+xml" = ["firefox.desktop"];

      # File manager
      "inode/directory" = ["org.kde.dolphin.desktop"];

      # Terminal
      "x-scheme-handler/terminal" = ["ghostty.desktop"];

      # Video files
      "video/quicktime" = ["mpv-2.desktop"];
      "video/x-matroska" = ["mpv-2.desktop"];

      # PDF files
      "application/pdf" = ["firefox.desktop"];

      # Text editor
      "text/plain" = ["nvim.desktop"];

      # Microsoft Office formats
      "application/msword" = ["firefox.desktop"];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ["firefox.desktop"];
      "application/vnd.ms-excel" = ["firefox.desktop"];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = ["firefox.desktop"];
      "application/vnd.ms-powerpoint" = ["firefox.desktop"];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = ["firefox.desktop"];

      # Other handlers
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];
      "x-scheme-handler/postman" = ["Postman.desktop"];
      "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];
    };

    associations.added = {
      "inode/directory" = ["org.kde.dolphin.desktop"];
      "text/html" = ["firefox.desktop"];
      "video/quicktime" = ["mpv-2.desktop"];
      "video/x-matroska" = ["mpv-2.desktop"];
      "application/pdf" = ["firefox.desktop"];
      "text/plain" = ["nvim.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/terminal" = ["ghostty.desktop"];
      "x-scheme-handler/tonsite" = ["org.telegram.desktop.desktop"];
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users.${username} = import ./home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  system.stateVersion = "24.05";
}
