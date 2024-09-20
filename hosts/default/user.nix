{ lib, config, pkgs, ... }:

let
  userName = "roncrush";
in
{
  options = {
  };
  config = {
    users.users.${userName} = {
      isNormalUser = true;
      description = userDescription;
      shell = pkgs.zsh; 
      extraGroups = [ "wheel"  "docker" ];
    };
    programs.zsh.enable = true;
  };
}
