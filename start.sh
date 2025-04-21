#!/bin/bash

# Exit on error
set -e

echo "Starting Security Compliance Framework..."

# Kill any existing processes
echo "Cleaning up existing processes..."
lsof -ti:3000 | xargs kill -9 2>/dev/null || true
lsof -ti:8000 | xargs kill -9 2>/dev/null || true

# Start dashboard
echo "Starting dashboard..."
cd dashboard
npm install
echo "Starting Vite development server..."
npm run dev -- --host 0.0.0.0 &

# Wait for dashboard to start
echo "Waiting for dashboard to start..."
sleep 5

echo "Dashboard should be running at http://localhost:3000" 