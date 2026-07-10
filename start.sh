#!/bin/sh
set -e

export N8N_PORT=5679
export PROXY_PORT=5678

# Start health check proxy in background
node /home/node/proxy.js &
PROXY_PID=$!

# Kill proxy when n8n exits
cleanup() {
  kill $PROXY_PID 2>/dev/null
  exit
}
trap cleanup SIGTERM SIGINT

# Start n8n on port 5679 (proxied from 5678)
n8n start &
N8N_PID=$!

wait $N8N_PID
cleanup
