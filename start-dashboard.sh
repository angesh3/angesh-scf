#!/bin/bash

# Kill any existing processes on port 3000
lsof -ti:3000 | xargs kill -9 2>/dev/null || true

# Navigate to dashboard directory
cd dashboard

# Install dependencies if needed
npm install

# Start the development server
npm run dev 