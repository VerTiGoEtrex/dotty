{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.programs.gimp;
in
{
  options.programs.gimp = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Installs GIMP via homebrew cask
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [ { 
      assertion = config.homebrew.enable == true;
      message = "homebrew.enable must be set to install GIMP.";
    } ];
    homebrew.casks = [ "gimp" ];
  };
}
