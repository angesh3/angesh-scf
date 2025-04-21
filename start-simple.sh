#!/bin/bash

# Exit on error
set -e

echo "Starting Simple Dashboard..."

# Kill any existing processes
echo "Cleaning up existing processes..."
pkill -f "node" || true
pkill -f "npm" || true

# Remove existing dashboard if it exists
rm -rf dashboard

# Create new Vite project
echo "Creating new Vite project..."
npm create vite@latest dashboard -- --template react

# Move into dashboard directory
cd dashboard

# Install dependencies
echo "Installing dependencies..."
npm install

# Create simple App.jsx
cat > src/App.jsx << 'EOL2'
function App() {
  return (
    <div style={{ padding: '2rem' }}>
      <h1>Security Compliance Framework</h1>
      <p>Dashboard is running successfully!</p>
    </div>
  )
}

export default App
EOL2

# Start the development server
echo "Starting development server..."
npm run dev -- --host
