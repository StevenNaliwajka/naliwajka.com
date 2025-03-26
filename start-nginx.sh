#!/bin/bash

set -e
cd "$(dirname "$0")"

PROJECT_ROOT="$(pwd)"
NGINX_BIN="$PROJECT_ROOT/nginx/sbin/nginx"
NGINX_CONF="$PROJECT_ROOT/Codebase/Config/nginx.conf"
PID_FILE="/tmp/nginx-local.pid"

if [ -f "$PROJECT_ROOT/nginx/logs/nginx.pid" ]; then
    rm -f "$PROJECT_ROOT/nginx/logs/nginx.pid"
fi

# Optionally run deploy
DEPLOY_SCRIPT="$PROJECT_ROOT/Codebase/Deploy/deploy.sh"
if [ -f "$DEPLOY_SCRIPT" ]; then
    echo "Deploying site configs before starting Nginx..."
    bash "$DEPLOY_SCRIPT"
fi

# Check nginx exists
if [ ! -f "$NGINX_BIN" ]; then
    echo "Nginx not found. Run ./setup.sh first."
    exit 1
fi

# Stop if already running
if pgrep -f "$NGINX_BIN" > /dev/null; then
    echo "Stopping existing Nginx instance..."
    $NGINX_BIN -s stop || true
    sleep 1
fi

# Start Nginx
echo "Starting local Nginx from: $NGINX_BIN"
$NGINX_BIN -c "$NGINX_CONF"

echo "Nginx is now running using $NGINX_CONF"
