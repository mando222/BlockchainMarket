import React, { useState, useEffect } from 'react';
import { TextField, Button, List, ListItem, ListItemText, Typography, Paper } from '@mui/material';

const Messaging = ({ currentUser, recipient }) => {
  const [messages, setMessages] = useState([]);
  const [newMessage, setNewMessage] = useState('');

  useEffect(() => {
    fetchMessages();
  }, [recipient]);

  const fetchMessages = async () => {
    try {
      const response = await fetch(`/api/get-messages/${currentUser}`);
      const data = await response.json();
      setMessages(data.filter(msg => msg.sender === recipient || msg.recipient === recipient));
    } catch (error) {
      console.error('Error fetching messages:', error);
    }
  };

  const sendMessage = async () => {
    try {
      await fetch('/api/send-message', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          sender: currentUser,
          recipient: recipient,
          content: newMessage,
        }),
      });
      setNewMessage('');
      fetchMessages();
    } catch (error) {
      console.error('Error sending message:', error);
    }
  };

  return (
    <Paper elevation={3} style={{ padding: '20px', maxWidth: '500px', margin: 'auto' }}>
      <Typography variant="h6" gutterBottom>
        Messaging with {recipient}
      </Typography>
      <List>
        {messages.map((msg, index) => (
          <ListItem key={index}>
            <ListItemText
              primary={msg.sender === currentUser ? 'You' : msg.sender}
              secondary={msg.content}
            />
          </ListItem>
        ))}
      </List>
      <TextField
        fullWidth
        variant="outlined"
        value={newMessage}
        onChange={(e) => setNewMessage(e.target.value)}
        placeholder="Type your message"
        margin="normal"
      />
      <Button variant="contained" color="primary" onClick={sendMessage}>
        Send
      </Button>
    </Paper>
  );
};

export default Messaging;