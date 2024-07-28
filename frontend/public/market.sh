#!/bin/bash

VERSION="1.1.0"

# Function to display help message
show_help() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  start    Start the project"
    echo "  stop     Stop the project"
    echo "  restart  Restart the project"
    echo "  install  Install project dependencies"
    echo "  -h       Display this help message"
    echo "  -v       Display version information"
}

# Function to display version
show_version() {
    echo "Blockchain Marketplace Launch Script v$VERSION"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install dependencies
install_dependencies() {
    echo "Installing project dependencies..."

    # Install Go dependencies
    echo "Installing Go dependencies..."
    cd backend
    if command_exists go; then
        go mod download
        go mod verify
    else
        echo "Error: Go is not installed. Please install Go and try again."
        exit 1
    fi
    cd ..

    # Install Node.js dependencies
    echo "Installing Node.js dependencies..."
    cd frontend
    if command_exists npm; then
        npm install
    else
        echo "Error: npm is not installed. Please install Node.js and npm, then try again."
        exit 1
    fi
    cd ..

    echo "Dependencies installed successfully!"
}

# File to store PIDs
PID_FILE=".project_pids"

# Function to start the backend
start_backend() {
    echo "Starting Cosmos SDK backend..."
    cd backend
    if [ ! -f "build/marketplaced" ]; then
        echo "Building marketplaced..."
        go build -o build/marketplaced ./cmd/marketplaced
    fi
    ./build/marketplaced start &
    BACKEND_PID=$!
    cd ..
    echo $BACKEND_PID > $PID_FILE
    echo "Backend started with PID $BACKEND_PID"
}

# Function to start the frontend
start_frontend() {
    echo "Starting React frontend..."
    cd frontend
    npm start &
    FRONTEND_PID=$!
    cd ..
    echo $FRONTEND_PID >> $PID_FILE
    echo "Frontend started with PID $FRONTEND_PID"
}

# Function to stop all processes
stop_all() {
    echo "Stopping all processes..."
    if [ -f $PID_FILE ]; then
        while read pid; do
            if kill $pid 2>/dev/null; then
                echo "Process with PID $pid stopped"
            else
                echo "Failed to stop process with PID $pid"
            fi
        done < $PID_FILE
        rm $PID_FILE
    else
        echo "No running processes found"
    fi
}

# Function to start all processes
start_all() {
    start_backend
    start_frontend
    echo "Both backend and frontend are now running."
}

# Main execution
case "$1" in
    start)
        start_all
        ;;
    stop)
        stop_all
        ;;
    restart)
        stop_all
        start_all
        ;;
    install)
        install_dependencies
        ;;
    -h|--help)
        show_help
        ;;
    -v|--version)
        show_version
        ;;
    *)
        echo "Invalid option. Use -h for help."
        exit 1
        ;;
esac

# If starting, wait for user input to keep the script running
if [ "$1" = "start" ] || [ "$1" = "restart" ]; then
    echo "Press Ctrl+C to stop all processes and exit."
    wait
fi
