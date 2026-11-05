#!/usr/bin/env bash

set -e

# Source utility functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/utils.sh"

log_info "Starting application installation process..."

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
        run_app_script "$app_path" "install.sh"
    fi
done

log_success "Application installation process finished successfully!"
