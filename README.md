Install Nix.
I have it setup for multi-user which I highly recommend

```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Install homebrew.
Homebrew provides an easy way to install a few mac GUI apps via `cask` or `mas`.
I'm not a fan of this dependency - ideally everything is pure (and apps cannot update themselves) - but this is a necessary evil to get useful apps like Alfred installed.

TODO: Specify your hostname and username...

Build, and switch to the dotfiles

```
cd <THIS-REPO>
nix build .#darwinConfigurations.$(hostname).system --extra-experimental-features nix-command --extra-experimental-features flakes
./result/sw/bin/darwin-rebuild switch --flake .#$(hostname)
```

note, `--extra-experimental-features` is only needed the first time around.
After the first build, the configuration will edit `/etc/nix/nix.conf` to enable flakes and nix-command by default


Open a new terminal - ensure you can access `darwin-rebuild` with the bootstrapped config.

```
which darwin-rebuild
```
