#!/bin/bash

set -e

# Ensure logs directory exists
LOG_DIR="$PROJECT_ROOT/logs"
echo "Ensuring log directory exists at: $LOG_DIR"
mkdir -p "$LOG_DIR"


echo "Starting full setup..."

# Install Nginx
echo ""
echo "Installing local Nginx..."
bash ./Codebase/Deploy/install-nginx.sh

echo ""
echo "Setup complete!"
echo ""
echo "Verify config ./Config/sites-available/naliwajka.com"
echo ""
echo "Once configured, start:  bash start-nginx.sh"
