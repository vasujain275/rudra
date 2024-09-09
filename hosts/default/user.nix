{ lib, config, pkgs, ... }:

let
  userName = "vasu";
  userDescription = "Vasu Jain";
in
{
  options = {
  };
  config = {
    users.users.${userName} = {
      isNormalUser = true;
      description = userDescription;
      shell = pkgs.zsh; 
      extraGroups = [ "wheel" ];
    };
    programs.zsh.enable = true;
  };
}
