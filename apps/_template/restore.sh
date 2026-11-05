#!/usr/bin/env bash
# Template restore script
# $1 = Source backup directory path

BACKUP_SRC="$1"
APP_NAME="$(basename "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")"
APP_BACKUP_DIR="$BACKUP_SRC/$APP_NAME"

echo "Restoring $APP_NAME from $APP_BACKUP_DIR..."
# cp -r "$APP_BACKUP_DIR/"* ~/.config/app/
