{ pkgs, lib, config, home-manager, nix-darwin, inputs, ... }: {

home.stateVersion = "21.11";
home.packages = with pkgs; [
];

programs.zsh.enable = true;

programs.git = {
  enable = true;
  userName = "ncrocker";
  userEmail = "2846960+VerTiGoEtrex@users.noreply.github.com";
  delta = {
    enable = true;
    options = {
      syntax-theme = "Nord";
      line-numbers = true;
    };
  };
  ignores = [ ".DS_Store" ];
};

programs.bat = {
  enable = true;
  config = { theme = "Nord"; };
};
}
