#!/usr/bin/env bash

# Define variables for directories and files
USER_HOME=$(eval echo ~$SUDO_USER)
RUDRA_DIR="$USER_HOME/rudra"
CACHE_DIR="$USER_HOME/.cache"
WALL_PNG_SRC="$RUDRA_DIR/config/assets/wall.png"
WALL_PNG_DEST="$CACHE_DIR/wall.png"
GIT_REPO="git@github.com:vasujain275/.dotfiles.git"
DOTFILES_DIR="$USER_HOME/.dotfiles"

# Ensure the script is run with the proper permissions
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root using sudo."
    exit 1
fi

# Navigate to ~/rudra
cd "$RUDRA_DIR" || { echo "Failed to cd to $RUDRA_DIR"; exit 1; }

# Create ~/.cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Copy wall.png to ~/.cache
cp "$WALL_PNG_SRC" "$WALL_PNG_DEST" || { echo "Failed to copy $WALL_PNG_SRC to $WALL_PNG_DEST"; exit 1; }

# Run nixos-generate-config command
sudo nixos-generate-config --show-hardware-config > "$RUDRA_DIR/hosts/default/hardware-configuration.nix" || { echo "Failed to generate hardware configuration"; exit 1; }

# Navigate to home directory
cd "$USER_HOME" || { echo "Failed to cd to home directory"; exit 1; }

# Clone the Git repository
git clone "$GIT_REPO" || { echo "Failed to clone $GIT_REPO"; exit 1; }

# Navigate to ~/.dotfiles
cd "$DOTFILES_DIR" || { echo "Failed to cd to $DOTFILES_DIR"; exit 1; }

# Stow dotfiles
stow --adopt . || { echo "Failed to stow dotfiles"; exit 1; }

# Navigate back to ~/rudra
cd "$RUDRA_DIR" || { echo "Failed to cd to $RUDRA_DIR"; exit 1; }

# Rebuild NixOS configuration
sudo nixos-rebuild switch --flake .#default || { echo "Failed to rebuild NixOS configuration"; exit 1; }

echo "Script completed successfully."
