# ❄️🐟 Nix completions.fish

> [!NOTE]
>
> [Fish completion for the `nix` command](https://github.com/NixOS/nix/blob/master/misc/fish/completion.fish) was added in **Nix 2.4**
>
> You may not need this plugin.

> [!WARNING]
>
> This project is a work in progress.
>
> Due to the nature of shell completions, corrections and improvements are
> always welcome.

[Fish](https://fishshell.com/) completions for the [main `nix` commands](https://nix.dev/manual/nix/latest/command-ref/main-commands).

Many descriptions are ported from [ZSH Completions for Nix](https://github.com/nix-community/nix-zsh-completions).

> This is a fork of @dmitrii-galantsev's [nix-completions.fish](https://github.com/dmitrii-galantsev/nix-completions.fish).
>
> Which itself of a fork of @kidonng's [nix-completions.fish](https://github.com/kidonng/nix-completions.fish).

## Installation

- [plug.fish](https://github.com/kidonng/plug.fish)

  ```sh
  plug install kris3713/nix-completions.fish
  ```

- [Fisher](https://github.com/jorgebucaran/fisher)

  ```sh
  fisher install kris3713/nix-completions.fish
  ```

- [Nix flakes](https://zero-to-nix.com/concepts/flakes/)

  Add the following to your `flake.nix` inputs and outputs:

  ```nix
  {
    # other nix expressions...
    inputs = {
      # You can name it anything you want, it doesn't matter
      nix-completions_fish = {
        url = "github:kris3713/nix-completions.fish";
        flake = false; # Make sure this is false, otherwise `nix flake update` will fail.
      };

      # other inputs...
    };

    outputs =
      {
        nix-completions_fish,
        # other outputs...
        ...
      };

    # other nix expressions...
  }
  ```

  You can then use this in your **home-manager** configuration or **NixOS** configuration
  if you are managing you fish installation with either of those.


  <details>
    <summary> Example: <strong>home-manager</strong> </summary>

    ```nix
    { config, pkgs, lib, nix-completions_fish, ... }:

    # other nix expressions...
    {

      programs.fish = {
        enable = true;

        plugins = [
          { # nix-completions.fish
            name = "nix-completions";
            src = nix-completions_fish;
          }
        ];
      }

      # other nix expressions...
    }
    ```

  </details>

## Completions

- [ ] `nix-build`
- [x] `nix-channel`
- [x] `nix-collect-garbage`
- [x] `nix-copy-closure`
- [x] `nix-env`
  - [x] Common options
  - [x] Subcommands
- [x] `nix-hash`
- [x] `nix-instantiate`
- [x] `nix-prefetch-url`
- [ ] `nix-shell`
- [ ] `nix-store`
