# Homebrew casks...

Not a fan of homebrew or casks now that Nix is around.

## However... 

- Many Mac GUI apps are available through cask. Convenient.
- Many Mac GUI apps like to manage their own updates. Annoying.
- Nix, home-manager, and nix-darwin all struggle with symlinks to `(~)/Applications` and Spotlight. No Alfred search :(

## So...

We compromise.
On Linux, everything will be installed the "correct" way.
On Mac, when we can, we use Nix (CLI apps) but for gui (`*.app`) we use cask until [this issue](https://github.com/LnL7/nix-darwin/issues/214) is solved.