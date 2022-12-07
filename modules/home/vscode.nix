{ config, pkgs, lib, ... }: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
  };
}
