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

# Function to check Go version
check_go_version() {
    minimum_version="1.18"
    recommended_version="1.21"
    current_version=$(go version | awk '{print $3}' | sed 's/go//')
    
    if [ "$(printf '%s\n' "$minimum_version" "$current_version" | sort -V | head -n1)" != "$minimum_version" ]; then
        echo "Error: Go version $minimum_version or higher is required. You have version $current_version."
        echo "Please upgrade Go and try again."
        exit 1
    elif [ "$(printf '%s\n' "$recommended_version" "$current_version" | sort -V | head -n1)" != "$current_version" ]; then
        echo "Warning: You're using Go version $current_version. We recommend upgrading to version $recommended_version or higher for best compatibility."
        echo "You can continue with the current version, but you may encounter issues with some dependencies."
        read -p "Do you want to continue with the current Go version? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Installation cancelled. Please upgrade Go and try again."
            exit 1
        fi
    fi
}

# Function to install dependencies
install_dependencies() {
    echo "Installing project dependencies..."

    # Install Go dependencies
    echo "Installing Go dependencies..."
    cd backend
    if command_exists go; then
        check_go_version

        # Ensure correct permissions for entire Go workspace
        GO_WORKSPACE="$HOME/go"
        if [ -d "$GO_WORKSPACE" ]; then
            echo "Ensuring correct permissions for Go workspace..."
            sudo chown -R $(whoami) "$GO_WORKSPACE"
            echo "Go workspace permissions updated."
        else
            echo "Go workspace not found at $GO_WORKSPACE. Skipping permissions update."
        fi

        # Attempt to download and verify modules
        echo "Downloading Go modules..."
        if ! go mod download; then
            echo "Error: Failed to download Go dependencies. Attempting to troubleshoot..."
            
            echo "Running go mod tidy..."
            go mod tidy
            
            echo "Attempting to download dependencies again..."
            if ! go mod download; then
                echo "Error: Failed to download Go dependencies even after running go mod tidy."
                echo "Here's more information:"
                go mod verify
                echo "Please check your go.mod file and ensure all dependencies are correctly specified."
                echo "You may need to manually resolve version conflicts or update dependency versions."
                exit 1
            fi
        fi

        echo "Verifying Go modules..."
        if ! go mod verify; then
            echo "Warning: Go module verification failed. This might indicate issues with dependencies."
            echo "Attempting to continue, but you may encounter problems later."
        fi

        echo "Go dependencies installed and verified successfully."
    else
        echo "Error: Go is not installed. Please install Go and try again."
        exit 1
    fi
    cd ..

    # Install Node.js dependencies
   echo "Installing Node.js dependencies..."
    cd frontend
    if command_exists npm; then
        if ! npm install; then
            echo "Error: Failed to install Node.js dependencies. Please check your internet connection and try again."
            exit 1
        fi
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
        all_stopped=true
        while read pid; do
            if ps -p $pid > /dev/null 2>&1; then
                echo "Attempting to stop process with PID $pid"
                if kill $pid 2>/dev/null; then
                    echo "Process with PID $pid stopped successfully"
                else
                    echo "Failed to stop process with PID $pid using SIGTERM. Attempting SIGKILL..."
                    if kill -9 $pid 2>/dev/null; then
                        echo "Process with PID $pid forcefully terminated"
                    else
                        echo "Failed to forcefully terminate process with PID $pid. It may require manual intervention."
                        all_stopped=false
                    fi
                fi
            else
                echo "Process with PID $pid is no longer running"
            fi
        done < $PID_FILE

        if $all_stopped; then
            rm $PID_FILE
            echo "All processes stopped successfully. PID file removed."
        else
            echo "Some processes could not be stopped. PID file retained for further action."
        fi
    else
        echo "No PID file found. No processes to stop."
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