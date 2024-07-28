# Blockchain Marketplace

## Project Overview

Blockchain Marketplace is a decentralized application (dApp) that combines the power of Cosmos SDK for backend blockchain operations with a React frontend for a seamless user experience. This project implements a privacy-preserving marketplace where users can list and browse products securely.

### Key Features

- Decentralized marketplace built on Cosmos SDK
- Privacy-preserving listings
- User-friendly React frontend
- Secure messaging between buyers and sellers

## Project Structure

```
blockchain-marketplace/
├── backend/
Go code here
├── frontend/
JS Ract code here
├── market.sh
├── .gitignore
└── README.md
```

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Go (version 1.18 or later) installed
- Node.js and npm installed
- Basic understanding of blockchain concepts and React

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
   - Install Node.js dependencies for the frontend
   - Set up necessary configurations

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

## Development

- Backend development: Navigate to the `backend/` directory and modify the Cosmos SDK modules as needed.
- Frontend development: Navigate to the `frontend/` directory. The React application is set up with a basic structure. Modify components in the `src/` directory as needed.

## Troubleshooting

If you encounter any issues during setup or running the application:

1. Ensure you have the correct versions of Go and Node.js installed.
2. Check the console output for any error messages.
3. Try running `./market.sh install` again to ensure all dependencies are properly installed.
4. If you're having issues with Go modules, try running `go mod tidy` in the `backend/` directory.
5. For frontend issues, ensure the `browserslist` configuration is present in `frontend/package.json`.

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