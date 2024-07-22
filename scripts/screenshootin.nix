{ pkgs }:

pkgs.writeShellScriptBin "screenshootin" ''
  grim -g "$(slurp)" - | swappy -f -
''
