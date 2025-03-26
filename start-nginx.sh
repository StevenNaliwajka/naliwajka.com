#!/bin/bash

set -e
cd "$(dirname "$0")"

PROJECT_ROOT="$(pwd)"
NGINX_BIN="$PROJECT_ROOT/nginx/sbin/nginx"
NGINX_CONF="$PROJECT_ROOT/Codebase/Config/nginx.conf"
PID_FILE="/tmp/nginx-local.pid"


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

# Confirm it actually started
sleep 0.5
if [ -f "$PID_FILE" ] && ps -p "$(cat "$PID_FILE")" > /dev/null 2>&1; then
    echo "Nginx is now running using $NGINX_CONF (PID: $(cat "$PID_FILE"))"
else
    echo "Nginx failed to start. Check logs or config."
    exit 1
fi