#!/bin/bash

# Exit on error
set -e

echo "Starting Security Compliance Framework Dashboard..."

# Kill any existing processes
echo "Cleaning up existing processes..."
pkill -f "node" || true
pkill -f "npm" || true

# Remove existing dashboard if it exists
rm -rf dashboard

# Create new Vite project
echo "Creating new Vite project..."
npm create vite@latest dashboard -- --template react-ts

# Install dependencies
echo "Installing dependencies..."
cd dashboard
npm install
npm install @mui/material @emotion/styled @emotion/react @mui/icons-material react-router-dom axios

# Start the development server
echo "Starting development server..."
npm run dev -- --host 