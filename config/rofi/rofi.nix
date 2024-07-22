{ pkgs, config, lib, ... }:

{
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        modi = "drun,filebrowser,run";
        show-icons = true;
        icon-theme = "Papirus";
        location = 0;
        font = "JetBrainsMono Nerd Font Mono 12";
        drun-display-format = "{icon} {name}";
        display-drun = " Apps";
        display-run = " Run";
        display-filebrowser = " File";
      };
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            bg = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base00}");
            bg-alt = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base09}");
            foreground = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base01}");
            selected = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base08}");
            active = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base0B}");
            text-selected = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base00}");
            text-color = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base05}");
            border-color = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base0F}");
            urgent = lib.mkForce (mkLiteral "#${config.stylix.base16Scheme.base0E}");
          };
          "window" = {
            width = mkLiteral "50%";
            transparency = "real";
            orientation = mkLiteral "vertical";
            cursor = mkLiteral "default";
            spacing = mkLiteral "0px";
            border = mkLiteral "2px";
            border-color = "@border-color";
            border-radius = mkLiteral "20px";
            background-color = lib.mkForce (mkLiteral "@bg");
          };
          "mainbox" = {
            padding = mkLiteral "15px";
            enabled = true;
            orientation = mkLiteral "vertical";
            children = map mkLiteral [
              "inputbar"
              "listbox"
            ];
            background-color = lib.mkForce (mkLiteral "transparent");
          };
          "inputbar" = {
            enabled = true;
            padding = mkLiteral "10px 10px 200px 10px";
            margin = mkLiteral "10px";
            background-color = lib.mkForce (mkLiteral "transparent");
            border-radius = "25px";
            orientation = mkLiteral "horizontal";
            children = map mkLiteral [
              "entry"
              "dummy"
              "mode-switcher"
            ];
            background-image = mkLiteral ''url("~/.cache/wall.png", width)'';
          };
          "entry" = {
            enabled = true;
            expand = false;
            width = mkLiteral "20%";
            padding = mkLiteral "10px";
            border-radius = mkLiteral "12px";
            background-color = lib.mkForce (mkLiteral "@selected");
            text-color = lib.mkForce (mkLiteral "@text-selected");
            cursor = mkLiteral "text";
            placeholder = "🖥️ Search ";
            placeholder-color = mkLiteral "inherit";
          };
          "listbox" = {
            spacing = mkLiteral "10px";
            padding = mkLiteral "10px";
            background-color = lib.mkForce (mkLiteral "transparent");
            orientation = mkLiteral "vertical";
            children = map mkLiteral [
              "message"
              "listview"
            ];
          };
          "listview" = {
            enabled = true;
            columns = 2;
            lines = 6;
            cycle = true;
            dynamic = true;
            scrollbar = false;
            layout = mkLiteral "vertical";
            reverse = false;
            fixed-height = false;
            fixed-columns = true;
            spacing = mkLiteral "10px";
            background-color = lib.mkForce (mkLiteral "transparent");
            border = mkLiteral "0px";
          };
          "dummy" = {
            expand = true;
            background-color = lib.mkForce (mkLiteral "transparent");
          };
          "mode-switcher" = {
            enabled = true;
            spacing = mkLiteral "10px";
            background-color = lib.mkForce (mkLiteral "transparent");
          };
          "button" = {
            width = mkLiteral "5%";
            padding = mkLiteral "12px";
            border-radius = mkLiteral "12px";
            background-color = lib.mkForce (mkLiteral "@text-selected");
            text-color = lib.mkForce (mkLiteral "@text-color");
            cursor = mkLiteral "pointer";
          };
          "button selected" = {
            background-color = lib.mkForce (mkLiteral "@selected");
            text-color = lib.mkForce (mkLiteral "@text-selected");
          };
          "scrollbar" = {
            width = mkLiteral "4px";
            border = 0;
            handle-color = lib.mkForce (mkLiteral "@border-color");
            handle-width = mkLiteral "8px";
            padding = 0;
          };
          "element" = {
            enabled = true;
            spacing = mkLiteral "10px";
            padding = mkLiteral "10px";
            border-radius = mkLiteral "12px";
            background-color = lib.mkForce (mkLiteral "transparent");
            cursor = mkLiteral "pointer";
          };
          "element normal.normal" = {
            background-color = lib.mkForce (mkLiteral "inherit");
            text-color = lib.mkForce (mkLiteral "inherit");
          };
          "element normal.urgent" = {
            background-color = lib.mkForce (mkLiteral "@urgent");
            text-color = lib.mkForce (mkLiteral "@foreground");
          };
          "element normal.active" = {
            background-color = lib.mkForce (mkLiteral "@active");
            text-color = lib.mkForce (mkLiteral "@foreground");
          };
          "element selected.normal" = {
            background-color = lib.mkForce (mkLiteral "@selected");
            text-color = lib.mkForce (mkLiteral "@text-selected");
          };
          "element selected.urgent" = {
            background-color = lib.mkForce (mkLiteral "@urgent");
            text-color = lib.mkForce (mkLiteral "@text-selected");
          };
          "element selected.active" = {
            background-color = lib.mkForce (mkLiteral "@urgent");
            text-color = lib.mkForce (mkLiteral "@text-selected");
          };
          "element alternate.normal" = {
            background-color = lib.mkForce (mkLiteral "transparent");
            text-color = lib.mkForce (mkLiteral "inherit");
          };
          "element alternate.urgent" = {
            background-color = lib.mkForce (mkLiteral "transparent");
            text-color = lib.mkForce (mkLiteral "inherit");
          };
          "element alternate.active" = {
            background-color = lib.mkForce (mkLiteral "transparent");
            text-color = lib.mkForce (mkLiteral "inherit");
          };
          "element-icon" = {
            background-color = lib.mkForce (mkLiteral "transparent");
            text-color = lib.mkForce (mkLiteral "inherit");
            size = mkLiteral "36px";
            cursor = mkLiteral "inherit";
          };
          "element-text" = {
            background-color = lib.mkForce (mkLiteral "transparent");
            font = "JetBrainsMono Nerd Font Mono 12";
            text-color = lib.mkForce (mkLiteral "inherit");
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "message" = {
            background-color = lib.mkForce (mkLiteral "transparent");
            border = mkLiteral "0px";
          };
          "textbox" = {
            padding = mkLiteral "12px";
            border-radius = mkLiteral "10px";
            background-color = lib.mkForce (mkLiteral "@bg-alt");
            text-color = lib.mkForce (mkLiteral "@bg");
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "error-message" = {
            padding = mkLiteral "12px";
            border-radius = mkLiteral "20px";
            background-color = lib.mkForce (mkLiteral "@bg-alt");
            text-color = lib.mkForce (mkLiteral "@bg");
          };
        };
    };
  };
}
