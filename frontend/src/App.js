import React, { useState } from 'react';
import { Container, AppBar, Toolbar, Typography, CssBaseline, Grid } from '@mui/material';
import ProductList from './components/ProductList';
import KeplrConnection from './components/KeplrConnection';
import Messaging from './components/Messaging';

function App() {
  const [currentUser, setCurrentUser] = useState('');
  const [selectedRecipient, setSelectedRecipient] = useState('');

  const handleConnect = (address) => {
    setCurrentUser(address);
  };

  const handleSelectRecipient = (recipient) => {
    setSelectedRecipient(recipient);
  };

  return (
    <>
      <CssBaseline />
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            Blockchain Marketplace
          </Typography>
          <KeplrConnection onConnect={handleConnect} />
        </Toolbar>
      </AppBar>
      <Container sx={{ mt: 4 }}>
        <Grid container spacing={3}>
          <Grid item xs={12} md={6}>
            <ProductList onSelectRecipient={handleSelectRecipient} />
          </Grid>
          <Grid item xs={12} md={6}>
            {currentUser && selectedRecipient && (
              <Messaging currentUser={currentUser} recipient={selectedRecipient} />
            )}
          </Grid>
        </Grid>
      </Container>
    </>
  );
}

export default App;