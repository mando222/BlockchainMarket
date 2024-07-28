# Blockchain Marketplace

## Project Overview

Blockchain Marketplace is a decentralized application (dApp) that combines the power of Cosmos SDK for backend blockchain operations with a React frontend for a seamless user experience. This project implements a privacy-preserving marketplace where users can list and browse products securely, connect their Keplr wallet, and engage in secure messaging using garbled circuit encryption.

### Key Features

- Decentralized marketplace built on Cosmos SDK
- Privacy-preserving listings
- User-friendly React frontend with Material-UI components
- Keplr wallet integration for the custom market chain
- Secure messaging between users using garbled circuit encryption
- Product listing and browsing functionality

## Project Structure

The project is organized into two main directories:

- `backend/`: Contains the Cosmos SDK-based blockchain implementation, including custom modules for the marketplace, garbled circuit encryption, and messaging API.

- `frontend/`: Houses the React-based user interface, including components for product listing, Keplr wallet integration, and secure messaging.

Additional files:
- `market.sh`: A script to manage the application (install dependencies, start/stop the project).
- `.gitignore`: Specifies intentionally untracked files to ignore.
- `README.md`: This file, providing project documentation.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Go (version 1.18 or later) installed
- Node.js and npm installed
- Keplr wallet browser extension installed
- Basic understanding of blockchain concepts, React, and Cosmos SDK

## Setup and Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/blockchain-marketplace.git
   cd blockchain-marketplace
   ```

2. Run the setup script:
   ```
   chmod +x market.sh
   ./market.sh install
   ```

   This script will:
   - Install Go dependencies for the backend
   - Install Node.js dependencies for the frontend (including Material-UI and Keplr wallet types)
   - Set up necessary configurations

3. Configure your custom chain:
   - Open `frontend/src/chainConfig.js` and update the configuration to match your custom market chain details.

## Usage

The `market.sh` script provides convenient commands to manage the application:

1. Start the project:
   ```
   ./market.sh start
   ```
   This command will start both the backend blockchain and the frontend React application.

2. Stop the project:
   ```
   ./market.sh stop
   ```
   This will stop all running processes related to the project.

3. Restart the project:
   ```
   ./market.sh restart
   ```
   This command stops all processes and then starts them again.

4. Display help:
   ```
   ./market.sh -h
   ```
   Shows available commands and their descriptions.

5. Display version:
   ```
   ./market.sh -v
   ```
   Shows the current version of the script.

## Features

### Keplr Wallet Integration

The application integrates with the Keplr wallet, allowing users to connect their wallet for the custom market chain. To use this feature:

1. Ensure you have the Keplr browser extension installed.
2. Click the "Connect Market Wallet" button in the application.
3. Follow the prompts to connect your wallet and add the custom chain if necessary.

### Secure Messaging

Users can send encrypted messages to each other using garbled circuit encryption. To use this feature:

1. Connect your Keplr wallet.
2. Select a product or user you want to message.
3. Use the messaging interface to send and receive encrypted messages.

## Development

- Backend development: Navigate to the `backend/` directory and modify the Cosmos SDK modules as needed. The `garbledCircuit.go` and `messagingAPI.go` files contain the implementation for secure messaging.
- Frontend development: Navigate to the `frontend/` directory. The React application is set up with a basic structure. Key components include:
  - `KeplrConnection.js`: Handles wallet connection
  - `ProductList.js`: Displays product listings
  - `Messaging.js`: Implements the secure messaging interface

## Troubleshooting

If you encounter any issues during setup or running the application:

1. Ensure you have the correct versions of Go and Node.js installed.
2. Check the console output for any error messages.
3. Try running `./market.sh install` again to ensure all dependencies are properly installed.
4. If you're having issues with Go modules, try running `go mod tidy` in the `backend/` directory.
5. For frontend issues, ensure the `browserslist` configuration is present in `frontend/package.json`.
6. Verify that your Keplr wallet is properly set up and connected to the correct network.
7. For messaging issues, ensure that the backend API endpoints are correctly configured and accessible.

## Contributing

Contributions to the Blockchain Marketplace project are welcome. Please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b <branch_name>`.
3. Make your changes and commit them: `git commit -m '<commit_message>'`
4. Push to the original branch: `git push origin <project_name>/<location>`
5. Create the pull request.

Alternatively, see the GitHub documentation on [creating a pull request](https://help.github.com/articles/creating-a-pull-request/).

## License

This project uses the following license: Unlicense license.

## Contact

TBD

## Acknowledgements

- Cosmos SDK
- React
- Material-UI
- Keplr Wallet