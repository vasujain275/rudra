{ lib, config, pkgs, ... }:

{

  options = {

  };

  config = {
    users.users."vasu" = {
      isNormalUser = true;
      description = "Vasu Jain";
      shell = pkgs.zsh; 
      extraGroups = [ "wheel" ];
    };
    programs.zsh.enable = true;
  };

}
