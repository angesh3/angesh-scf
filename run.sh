#!/bin/bash

# Exit on error
set -e

echo "Starting Security Compliance Framework..."

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

# Function to check if a port is in use
check_port() {
    lsof -i
}

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python -m venv venv
fi

# Activate virtual environment
source venv/bin/activate

# Install dependencies if needed
if ! command -v poetry &> /dev/null; then
    echo "Installing poetry..."
    pip install poetry
fi

# Install project dependencies
echo "Installing project dependencies..."
poetry install

# Install dashboard dependencies
echo "Installing dashboard dependencies..."
cd dashboard
npm install
cd ..

# Start services in the background
echo "Starting services..."
docker-compose up -d

# Start dashboard in the background
echo "Starting dashboard..."
cd dashboard
npm start &
cd ..

# Start API server
echo "Starting API server..."
poetry run uvicorn src.api.main:app --reload --port ${API_PORT:-8000}

# Kill existing processes on ports if they exist
kill_port() {
    local port=$1
    if lsof -ti:$port >/dev/null 2>&1; then
        echo
    fi
} 