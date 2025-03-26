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

# Start Nginx
echo "Starting local Nginx from: $NGINX_BIN"
$NGINX_BIN -c "$NGINX_CONF"

