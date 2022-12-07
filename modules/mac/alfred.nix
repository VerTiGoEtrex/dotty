{ config, pkgs, lib, ... }: {
  homebrew.enable = true;
  homebrew.casks = [
    "alfred"
  ];
}
