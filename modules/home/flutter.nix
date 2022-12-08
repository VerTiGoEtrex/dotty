# Extremely WIP - doesn't actually install flutter
# just adds hard-coded path to it
{ config, pkgs, lib, ... }: {
  # TODO make this per-user rather than whole-system
  # unless I can get a global install of flutter
  home.sessionPath = [ "$HOME/sources/flutter/bin" ];
}
