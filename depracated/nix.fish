# NOTE: This may no longer be needed since NixOS provides fish completions for the `nix` command
# See: https://github.com/NixOS/nix/blob/master/misc/fish/completion.fish

# second and ONLY second arg must be one of these
function __nix_complete_profile --description 'Complete nix profile commands'
    if ! __fish_seen_subcommand_from "profile"
        return 1
    end

    if ! __fish_is_nth_token 2
        return 1
    end

    for k in install remove list history
        echo "$k"
    end
end

function __nix_complete_profile_rm --description 'Remove a profile'
    if ! type -q nix
        return 1
    end

    if ! type -q jq
        return 1
    end

    # must hide errors from nix command because it breaks completions
    set -l packages (nix profile list --json 2>/dev/null | jq '.elements | .[] | .attrPath' -r | grep -Po '(?<=\.)[^.]+$')
    for k in $packages
        echo "$k"
    end
end

complete -c nix --exclusive

# Common options
complete -c nix -l debug -d "enable debug output"
complete -c nix -l help -d "show usage information"
complete -c nix -l help-config -d "show configuration options"
complete -c nix -l no-net -d "disable substituters and consider all previously downloaded files up-to-date"
complete -c nix -l option -d "set a Nix configuration option (overriding nix.conf)"
complete -c nix -l print-build-logs -s L -d "print full build logs on stderr"
complete -c nix -l quiet -d "decrease verbosity level"
complete -c nix -l verbose -s v -d "increase verbosity level"
complete -c nix -l version -d "show version information"

# Generate profile remove list
complete -c nix -n "__fish_seen_subcommand_from profile" -a "(__nix_complete_profile)"
complete -c nix -n "__fish_seen_subcommand_from profile && __fish_seen_subcommand_from remove" -a "(__nix_complete_profile_rm)"

# Subcommands

# My ~/.config/nix/nix.conf contains:
#   extra-experimental-features = nix-command flakes
# Generated from `nix` help text with:
#   NOCOLOR=1 nix help | grep -Po '(?<=· nix )([a-zA-Z_-]+) - .*' | string trim | string replace --regex '([\w-]+) - (.+)' 'complete -c nix -n __fish_use_subcommand -a $1 -d "$2"' | sort
complete -c nix -n __fish_use_subcommand -a build -d "build a derivation or fetch a store path"
complete -c nix -n __fish_use_subcommand -a bundle -d "bundle an application so that it works outside of the Nix store"
complete -c nix -n __fish_use_subcommand -a config -d "manipulate the Nix configuration"
complete -c nix -n __fish_use_subcommand -a copy -d "copy paths between Nix stores"
complete -c nix -n __fish_use_subcommand -a daemon -d "daemon to perform store operations on behalf of non-root clients"
complete -c nix -n __fish_use_subcommand -a derivation -d "Work with derivations, Nix's notion of a build plan."
complete -c nix -n __fish_use_subcommand -a develop -d "run a bash shell that provides the build environment of a derivation"
complete -c nix -n __fish_use_subcommand -a edit -d "open the Nix expression of a Nix package in $EDITOR"
complete -c nix -n __fish_use_subcommand -a env -d "manipulate the process environment"
complete -c nix -n __fish_use_subcommand -a eval -d "evaluate a Nix expression"
complete -c nix -n __fish_use_subcommand -a flake -d "manage Nix flakes"
complete -c nix -n __fish_use_subcommand -a fmt -d "reformat your code in the standard style"
complete -c nix -n __fish_use_subcommand -a hash -d "compute and convert cryptographic hashes"
complete -c nix -n __fish_use_subcommand -a help -d "show help about nix or a particular subcommand"
complete -c nix -n __fish_use_subcommand -a help-stores -d "show help about store types and their settings"
complete -c nix -n __fish_use_subcommand -a key -d "generate and convert Nix signing keys"
complete -c nix -n __fish_use_subcommand -a log -d "show the build log of the specified packages or paths, if available"
complete -c nix -n __fish_use_subcommand -a nar -d "create or inspect NAR files"
complete -c nix -n __fish_use_subcommand -a path-info -d "query information about store paths"
complete -c nix -n __fish_use_subcommand -a print-dev-env -d "print shell code that can be sourced by bash to reproduce the build environment of a derivation"
complete -c nix -n __fish_use_subcommand -a profile -d "manage Nix profiles"
complete -c nix -n __fish_use_subcommand -a realisation -d "manipulate a Nix realisation"
complete -c nix -n __fish_use_subcommand -a registry -d "manage the flake registry"
complete -c nix -n __fish_use_subcommand -a repl -d "start an interactive environment for evaluating Nix expressions"
complete -c nix -n __fish_use_subcommand -a run -d "run a Nix application"
complete -c nix -n __fish_use_subcommand -a search -d "search for packages"
complete -c nix -n __fish_use_subcommand -a store -d "manipulate a Nix store"
complete -c nix -n __fish_use_subcommand -a upgrade-nix -d "upgrade Nix to the latest stable version"
complete -c nix -n __fish_use_subcommand -a why-depends -d "show why a package has another package in its closure"

