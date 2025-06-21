#!/bin/bash
# ~/.local/bin/paste-image.sh

SOURCE="$1"
VAULT_DIR="$HOME/Documents/Latest_Documents/Obsidian_Vaults/obsidian-vault1/Obsidian_Vault1"
IMG_DIR="$VAULT_DIR/screen_shots"
BASENAME="$(basename "$SOURCE")"
TARGET="$IMG_DIR/$BASENAME"

mkdir -p "$IMG_DIR"
cp "$SOURCE" "$TARGET"

echo "![image](screen_shots/$BASENAME)"

