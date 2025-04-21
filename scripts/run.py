import os
import subprocess
import sys
from pathlib import Path

def setup_environment():
    """Set up the development environment."""
    print("Setting up environment...")
    
    # Create necessary directories if they don't exist
    directories = [
        'src/core/scanner',
        'src/core/remediation',
        'src/core/inventory',
        'src/core/reporting',
        'src/providers/aws',
        'src/rules/cis',
        'src/rules/custom',
        'src/api',
        'tests',
        'dashboard',
        'docs',
        'deploy',
        'ci'
    ]
    
    for directory in directories:
        Path(directory).mkdir(parents=True, exist_ok=True)

def start_services():
    """Start all required services using docker-compose."""
    print("Starting services...")
    try:
        subprocess.run(['docker-compose', 'up', '-d'], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error starting services: {e}")
        sys.exit(1)

def start_api():
    """Start the FastAPI server."""
    print("Starting API server...")
    try:
        subprocess.run(['uvicorn', 'src.api.main:app', '--reload', '--port', '8000'], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error starting API server: {e}")
        sys.exit(1)

if __name__ == "__main__":
    setup_environment()
    start_services()
    start_api() 