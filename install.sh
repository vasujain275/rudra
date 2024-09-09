#!/usr/bin/env bash

# Define variables for directories and files
USER_HOME=$(eval echo ~$SUDO_USER)
RUDRA_DIR="$USER_HOME/rudra"

# Run nixos-generate-config command
sudo nixos-generate-config --show-hardware-config > "$RUDRA_DIR/hosts/default/hardware-configuration.nix" || { echo "Failed to generate hardware configuration"; exit 1; }

# Navigate to home directory
cd "$USER_HOME" || { echo "Failed to cd to home directory"; exit 1; }

# Navigate back to ~/rudra
cd "$RUDRA_DIR" || { echo "Failed to cd to $RUDRA_DIR"; exit 1; }

# Rebuild NixOS configuration
sudo nixos-rebuild switch --flake .#default || { echo "Failed to rebuild NixOS configuration"; exit 1; }

echo "Script completed successfully."
