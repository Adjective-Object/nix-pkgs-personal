#!/usr/bin/env bash

# utils

command_exists () {
    type "$1" &> /dev/null ;
}

# bootstrap nix

if command_exists nix-env; then
    echo "nix installed"
else
    echo "installing nix"
    curl https://nixos.org/nix/install | sh
fi

# install packages
nix-env -iA nixpkgs.coreutils                   # GNU ls, etc
nix-env -iA nixpkgs.tree                        # tree is cool
nix-env -f ./default.nix -i zsh-adjective       # zsh
nix-env -f ./default.nix -i vim                 # vim

# other setup

echo "making .zsh folder"
mkdir -p $HOME/.zsh

echo "downloading LS_COLORS"
curl -s https://raw.githubusercontent.com/trapd00r/LS_COLORS/master/LS_COLORS > $HOME/.zsh/LS_COLORS

LOLA_NEEDED=1
if [ -f $HOME/.gitconfig ]; then
    cat $HOME/.gitconfig | grep -s "lola" >> /dev/null
    LOLA_NEEDED=$?
fi
if [ "$LOLA_NEEDED" == "1" ]; then
    echo "adding lola to gitconfig"
cat >> $HOME/.gitconfig << EndOfMessage
[alias]
        lol = log --graph --decorate --pretty=oneline --abbrev-commit
        lola = log --graph --decorate --pretty=oneline --abbrev-commit --all
[color]
        branch = auto
        diff = auto
        interactive = auto
        status = auto

EndOfMessage
else
    echo "lola already in gitconfig"
fi


