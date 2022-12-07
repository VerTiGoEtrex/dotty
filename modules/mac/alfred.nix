{ config, pkgs, lib, ... }:
with pkgs; 
let
  cfg = config.programs.alfred;
  pname = "alfred";
  version = "5.0.5_2096";
  url = "https://cachefly.alfredapp.com/Alfred_${version}.dmg";
  hash = "sha256-nSh0XOCp4SorzRMoFlehtPi0kqY+TqKxhhomG2JqOK0=";
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
        cp -R "Alfred 5.app" $out/Applications/
      '';

      meta.platforms = lib.platforms.darwin;
    };
in
with lib;
{
  options.programs.alfred = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Installs alfred
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = builtins.trace (builtins.toJSON [ drv ]) [ drv ];
  };
}
