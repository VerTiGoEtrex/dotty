{ config, pkgs, lib, ... }:
with pkgs; 
let
  cfg = config.programs.alfred;
in
with lib;
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
    homebrew.casks = [ 
      "alfred" 
    ];
  };
}
