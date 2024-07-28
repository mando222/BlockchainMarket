import React from 'react';
import { Container, AppBar, Toolbar, Typography, Button, CssBaseline } from '@mui/material';
import ProductList from './components/ProductList';

function App() {
  return (
    <>
      <CssBaseline />
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            Blockchain Marketplace
          </Typography>
          <Button color="inherit">Login</Button>
        </Toolbar>
      </AppBar>
      <Container sx={{ mt: 4 }}>
        <ProductList />
      </Container>
    </>
  );
}

export default App;