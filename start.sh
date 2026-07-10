#!/bin/sh
set -e

echo "=== Starting startup script at $(date) ==="

export N8N_PORT=5679
export PROXY_PORT=5678

echo "Starting proxy on port 5678 -> 5679..."
node /home/node/proxy.js &
PROXY_PID=$!
echo "Proxy PID: $PROXY_PID"

cleanup() {
  echo "Cleaning up proxy (PID $PROXY_PID)..."
  kill $PROXY_PID 2>/dev/null
  exit
}
trap cleanup SIGTERM SIGINT

echo "Starting n8n on port 5679..."
n8n start &
N8N_PID=$!
echo "n8n PID: $N8N_PID"

echo "Waiting for n8n..."
wait $N8N_PID
echo "n8n exited with code $?"
cleanup
