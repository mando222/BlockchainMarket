import React from 'react';
import { Card, CardContent, CardActions, Button, Typography, Grid } from '@mui/material';

const mockProducts = [
  { id: 1, name: 'Product 1', description: 'This is product 1', price: '$10' },
  { id: 2, name: 'Product 2', description: 'This is product 2', price: '$20' },
  { id: 3, name: 'Product 3', description: 'This is product 3', price: '$30' },
];

const ProductList = () => {
  return (
    <Grid container spacing={3}>
      {mockProducts.map((product) => (
        <Grid item xs={12} sm={6} md={4} key={product.id}>
          <Card>
            <CardContent>
              <Typography gutterBottom variant="h5" component="div">
                {product.name}
              </Typography>
              <Typography variant="body2" color="text.secondary">
                {product.description}
              </Typography>
              <Typography variant="h6" color="text.primary" sx={{ mt: 2 }}>
                {product.price}
              </Typography>
            </CardContent>
            <CardActions>
              <Button size="small" color="primary">
                View Details
              </Button>
              <Button size="small" color="secondary">
                Add to Cart
              </Button>
            </CardActions>
          </Card>
        </Grid>
      ))}
    </Grid>
  );
};

export default ProductList;