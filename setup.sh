#!/bin/bash

set -e

echo "Starting full setup..."

# Install Nginx
echo ""
echo "Installing local Nginx..."
bash ./Codebase/Install/install-nginx.sh

echo ""
echo "Setup complete!"
echo ""
echo "Verify config ./Config/sites-available/naliwajka.com"
echo ""
echo "Once configured, start:  bash start-nginx.sh"
