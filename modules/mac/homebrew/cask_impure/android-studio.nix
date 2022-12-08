{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.programs.android-studio;
in
{
  options.programs.android-studio = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Installs Android Studio via homebrew cask
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [ { 
      assertion = config.homebrew.enable == true;
      message = "homebrew.enable must be set to install Android Studio.";
    } ];
    homebrew.casks = [ "android-studio" ];
  };
}
