#!/usr/bin/env bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Helper to execute app scripts safely
run_app_script() {
    local app_dir="$1"
    local script_name="$2"
    shift 2
    local extra_args=("$@")

    local app_name
    app_name=$(basename "$app_dir")
    local script_path="$app_dir/$script_name"

    if [ -f "$script_path" ]; then
        log_info "Executing $script_name for app: $app_name..."
        chmod +x "$script_path"
        if "$script_path" "${extra_args[@]}"; then
            log_success "Completed $script_name for $app_name."
        else
            log_error "Failed $script_name for $app_name!"
            return 1
        fi
    else
        log_warn "No $script_name found for $app_name. Skipping."
    fi
}
