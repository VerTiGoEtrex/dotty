{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.programs.rectangle;
in
{
  options.programs.rectangle = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Installs Rectangle via homebrew cask
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [ { 
      assertion = config.homebrew.enable == true;
      message = "homebrew.enable must be set to install Rectangle.";
    } ];
    homebrew.casks = [ "rectangle" ];
  };
}
