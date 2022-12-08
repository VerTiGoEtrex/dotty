{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.programs.zoom;
in
{
  options.programs.zoom = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Installs Zoom via homebrew cask
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [ { 
      assertion = config.homebrew.enable == true;
      message = "homebrew.enable must be set to install Zoom.";
    } ];
    homebrew.casks = [ "zoom" ];
  };
}
