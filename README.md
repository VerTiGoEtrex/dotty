## Install 1Password

Sadly, this is not automated yet as it's not available on the app store for some reason.

## Install Nix.
I have it setup for multi-user which I highly recommend

```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

## Install homebrew.
Read `./modules/mac/cask_impure`.
Homebrew is a necessary evil - don't rely on it or use it if you can avoid it.

TODO: Specify your hostname and username...

## Build, and switch to the dotfiles

```
cd <THIS-REPO>
nix build .#darwinConfigurations.$(hostname).system --extra-experimental-features nix-command --extra-experimental-features flakes
./result/sw/bin/darwin-rebuild switch --flake .#$(hostname)
```

note, `--extra-experimental-features` is only needed the first time around.
After the first build, the configuration will edit `/etc/nix/nix.conf` to enable flakes and nix-command by default


## Open a new terminal - ensure you can access `darwin-rebuild` with the bootstrapped config.

```
which darwin-rebuild
```
