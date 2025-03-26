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

# Stop existing instance if running
if [ -f "$PID_FILE" ] && ps -p "$(cat "$PID_FILE")" > /dev/null 2>&1; then
    echo "Stopping existing Nginx instance..."
    $NGINX_BIN -s stop
    sleep 1
else
    echo "No running Nginx instance found to stop."
fi

# Start Nginx
echo "Starting local Nginx from: $NGINX_BIN"
$NGINX_BIN -c "$NGINX_CONF"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "Stopping existing Nginx instance (PID: $PID)..."
        kill -QUIT "$PID"
        sleep 1
    else
        echo "No running Nginx process found at PID $PID. Cleaning up stale PID file."
        rm -f "$PID_FILE"
    fi
else
    echo "No PID file found — Nginx does not appear to be running."
fi

