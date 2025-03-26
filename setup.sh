#!/bin/bash

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"
INSTALL_SCRIPT="$PROJECT_ROOT/Codebase/Deploy/install-nginx.sh"

# Ensure logs directory exists
LOG_DIR="$PROJECT_ROOT/logs"
echo "Ensuring log directory exists at: $LOG_DIR"
mkdir -p "$LOG_DIR"

echo ""
echo "Starting full setup..."

# Install Nginx
echo ""
echo "Installing local Nginx..."
bash "$INSTALL_SCRIPT"

echo ""
echo "Setup complete!"
echo ""
echo "Verify your config at: $PROJECT_ROOT/Codebase/Sites/sites-available/naliwajka.com"
echo "Then start Nginx using:  bash start-nginx.sh"
