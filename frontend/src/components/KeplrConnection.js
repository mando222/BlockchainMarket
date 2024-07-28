import React, { useState } from 'react';
import { Button, Typography } from '@mui/material';
import { chainConfig } from '../chainConfig';

const KeplrConnection = () => {
  const [address, setAddress] = useState('');

  const connectKeplr = async () => {
    if (!window.keplr) {
      alert("Please install Keplr extension");
      return;
    }

    try {
      // Check if the chain is already added to Keplr
      await window.keplr.enable(chainConfig.chainId);
    } catch (error) {
      // If the chain is not added, add it
      try {
        await window.keplr.experimentalSuggestChain(chainConfig);
        await window.keplr.enable(chainConfig.chainId);
      } catch (error) {
        console.error("Failed to suggest the chain", error);
        alert("Failed to add the market chain to Keplr");
        return;
      }
    }

    const offlineSigner = window.keplr.getOfflineSigner(chainConfig.chainId);
    const accounts = await offlineSigner.getAccounts();

    setAddress(accounts[0].address);
  };

  return (
    <div>
      {address ? (
        <Typography>Connected: {address}</Typography>
      ) : (
        <Button variant="contained" color="primary" onClick={connectKeplr}>
          Connect Market Wallet
        </Button>
      )}
    </div>
  );
};

export default KeplrConnection;