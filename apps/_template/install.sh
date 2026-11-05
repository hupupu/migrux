#!/usr/bin/env bash
# Template install script

APP_NAME="$(basename "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)")"

echo "Installing $APP_NAME..."
# sudo apt update && sudo apt install -y app
