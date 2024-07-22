{ pkgs }:

pkgs.writeShellScriptBin "emopicker9000" ''
      # Get user selection via wofi from emoji file.
      chosen=$(cat $HOME/.config/.emoji | ${pkgs.rofi-wayland}/bin/rofi -i -dmenu -config ~/.config/rofi/config-emoji.rasi | awk '{print $1}')

      # Exit if none chosen.
      [ -z "$chosen" ] && exit

      # If you run this command with an argument, it will automatically insert the
      # character. Otherwise, show a message that the emoji has been copied.
      if [ -n "$1" ]; then
  	    ${pkgs.ydotool}/bin/ydotool type "$chosen"
      else
          printf "$chosen" | ${pkgs.wl-clipboard}/bin/wl-copy
  	    ${pkgs.libnotify}/bin/notify-send "'$chosen' copied to clipboard." &
      fi
''
