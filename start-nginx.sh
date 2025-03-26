#!/bin/bash

set -e
cd "$(dirname "$0")"

PROJECT_ROOT="$(pwd)"
NGINX_BIN="$PROJECT_ROOT/nginx/sbin/nginx"
NGINX_CONF="$PROJECT_ROOT/Codebase/Config/nginx.conf"
PID_FILE="/tmp/nginx-local.pid"

# Optional cleanup
if [ -f "$PID_FILE" ]; then
    echo "Removing stale PID file..."
    rm -f "$PID_FILE"
fi

# Run deploy before start
DEPLOY_SCRIPT="$PROJECT_ROOT/Codebase/Deploy/deploy.sh"
if [ -f "$DEPLOY_SCRIPT" ]; then
    echo "Deploying site configs before starting Nginx..."
    bash "$DEPLOY_SCRIPT"
fi

# Stop existing instance
if [ -f "$PID_FILE" ]; then
    echo "Stopping existing Nginx instance..."
    $NGINX_BIN -s stop || true
    sleep 1
fi

echo "Starting local Nginx from: $NGINX_BIN"
$NGINX_BIN -c "$NGINX_CONF"

echo "Nginx is now running using $NGINX_CONF"
