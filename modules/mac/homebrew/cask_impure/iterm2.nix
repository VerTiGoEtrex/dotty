{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.programs.iterm2;
in
{
  options.programs.iterm2 = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Installs iterm2 via homebrew cask
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [ { 
      assertion = config.homebrew.enable == true;
      message = "homebrew.enable must be set to install Iterm2.";
    } ];
    homebrew.casks = [ "iterm2" ];
  };
}
