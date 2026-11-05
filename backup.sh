#!/usr/bin/env bash

set -e

# Source utility functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/utils.sh"

BACKUP_DEST="$1"

if [ -z "$BACKUP_DEST" ]; then
    read -rp "Enter target backup directory path (e.g., /media/user/external_drive/migrux_backup): " BACKUP_DEST
fi

if [ -z "$BACKUP_DEST" ]; then
    log_error "No backup destination provided. Exiting."
    exit 1
fi

log_info "Starting migration backup process to: $BACKUP_DEST"
mkdir -p "$BACKUP_DEST"

APPS_DIR="$SCRIPT_DIR/apps"

if [ ! -d "$APPS_DIR" ] || [ -z "$(ls -A "$APPS_DIR" 2>/dev/null)" ]; then
    log_warn "No application directories found in $APPS_DIR."
    exit 0
fi

for app_path in "$APPS_DIR"/*; do
    if [ -d "$app_path" ]; then
        app_name=$(basename "$app_path")
        # Ignore hidden/template directories starting with _ or .
        if [[ "$app_name" =~ ^[_.] ]]; then
            continue
        fi
        run_app_script "$app_path" "backup.sh" "$BACKUP_DEST"
    fi
done

log_success "Backup process finished successfully!"
