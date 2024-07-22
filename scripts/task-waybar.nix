{ pkgs }:

pkgs.writeShellScriptBin "task-waybar" ''
  sleep 0.1
  ${pkgs.swaynotificationcenter}/bin/swaync-client -t &
''
