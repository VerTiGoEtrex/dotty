{ config, pkgs, lib, ... }:
with pkgs; 
let
  cfg = config.programs.rectangle;
  pname = "rectangle";
  version = "0.63";
  url = "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
  hash = "sha256-xgO9fqf8PX0SwEsMVef3pBiaLblTgo9ZNrqHUn0+JIg=";
  drv = stdenvNoCC.mkDerivation rec {
      inherit pname version;

      src = fetchurl {
        inherit hash url;
      };

      unpackPhase = ''
        undmg $src
      '';

      nativeBuildInputs = [
        makeWrapper
        undmg
      ];

      installPhase = ''
        mkdir -p $out/Applications
        cp -R "Rectangle.app" $out/Applications/
      '';

      meta.platforms = lib.platforms.darwin;
    };
in
with lib;
{
  options.programs.rectangle = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Installs Rectangle
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ drv ];
  };
}
