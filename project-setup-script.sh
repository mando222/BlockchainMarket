#!/bin/bash

# Navigate to the root folder
cd blockchainmarket

# Create backend structure
mkdir -p backend/cmd/marketplaced
mkdir -p backend/x/marketplace/{keeper,types,client}
mkdir -p backend/app

# Create main.go
cat << EOF > backend/cmd/marketplaced/main.go
package main

import (
    "fmt"
)

func main() {
    fmt.Println("Marketplace Daemon Starting...")
}
EOF

# Create module.go
cat << EOF > backend/x/marketplace/module.go
package marketplace

// Module implementation goes here
EOF

# Create handler.go
cat << EOF > backend/x/marketplace/handler.go
package marketplace

// Handler implementation goes here
EOF

# Create app.go
cat << EOF > backend/app/app.go
package app

// App implementation goes here
EOF

# Create go.mod
cat << EOF > backend/go.mod
module github.com/yourusername/blockchainmarket/backend

go 1.16

require (
    github.com/cosmos/cosmos-sdk v0.45.1
    github.com/tendermint/tendermint v0.34.14
)
EOF

# Create frontend structure
mkdir -p frontend/{public,src/components}

# Create package.json
cat << EOF > frontend/package.json
{
  "name": "blockchainmarket-frontend",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "react": "^17.0.2",
    "react-dom": "^17.0.2",
    "react-scripts": "4.0.3"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject"
  }
}
EOF

# Create ProductCatalog.js
cat << EOF > frontend/src/components/ProductCatalog.js
import React from 'react';

const ProductCatalog = () => {
  return (
    <div>
      <h1>Product Catalog</h1>
      {/* Product list will go here */}
    </div>
  );
};

export default ProductCatalog;
EOF

# Create App.js
cat << EOF > frontend/src/App.js
import React from 'react';
import ProductCatalog from './components/ProductCatalog';

function App() {
  return (
    <div className="App">
      <ProductCatalog />
    </div>
  );
}

export default App;
EOF

# Create index.js
cat << EOF > frontend/src/index.js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);
EOF

# Create README files
echo "# Blockchain Marketplace" > README.md
echo "# Blockchain Marketplace Frontend" > frontend/README.md

# Create .gitignore
cat << EOF > .gitignore
# Dependencies
node_modules/

# Production
build/

# Misc
.DS_Store
.env.local
.env.development.local
.env.test.local
.env.production.local

npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Go binaries
*.exe
*.exe~
*.dll
*.so
*.dylib

# Test binary, built with 'go test -c'
*.test

# Output of the go coverage tool, specifically when used with LiteIDE
*.out

# Dependency directories (remove the comment below to include it)
# vendor/
EOF

echo "Project structure created successfully!"
