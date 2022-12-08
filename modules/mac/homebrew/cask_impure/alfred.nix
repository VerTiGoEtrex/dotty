{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.programs.alfred;
in
{
  options.programs.alfred = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Installs Alfred via homebrew cask
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [ { 
      assertion = config.homebrew.enable == true;
      message = "homebrew.enable must be set to install Alfred.";
    } ];
    homebrew.casks = [ "alfred" ];
  };
}
