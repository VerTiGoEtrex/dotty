{ config, lib, pkgs, ... }: 
{
  imports = [
    ./cask_impure/alfred.nix
    ./cask_impure/android-studio.nix
    ./cask_impure/gimp.nix
    ./cask_impure/iterm2.nix
    ./cask_impure/rectangle.nix
    ./cask_impure/zoom.nix
  ];

  options = {};

  config = {
    # We use homebrew cask to install a few GUI apps
    homebrew.enable = true;
    homebrew.global.autoUpdate = false; # Don't want homebrew to change things unless we `darwin-rebuild switch` for extra stability.
    homebrew.onActivation.cleanup = "zap"; # Anything not referenced by nix will be zapped (aggressively uninstalled including user preferences, etc.).
    homebrew.global.brewfile = true; # Make homebrew use our brewfile by default if you `brew bundle`
    homebrew.taps = [
      "homebrew/cask"
    ];

    # TODO add 1password and xcode, possibly via homebrew.masApps? Prefer no.
    
    environment.interactiveShellInit = builtins.trace "wat" ''
      eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
    '';

    system.activationScripts.preUserActivation.text = ''
      if [ ! -f ${config.homebrew.brewPrefix}/brew ]; then
        echo "Attempting to install homebrew for you!"
        ${pkgs.bash}/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      fi
      echo >&2 "Friendly reminder: To remain idempotent, nix will not auto-upgrade homebrew or its formulae."
      echo >&2 "Periodically run 'brew update && brew upgrade --cask' on your own convenience."
    '';
  };
}