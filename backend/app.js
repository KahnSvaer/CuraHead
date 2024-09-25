// app.js
const express = require('express');
const connectDB = require('./src/config/db');
const dotenv = require('dotenv');
const dataRoutes = require('./src/routes/dataRoutes'); // Import the routes

// Load environment variables
dotenv.config();

// Connect to MongoDB
connectDB();

const app = express();

// Use the data routes
app.use('/api', dataRoutes); // Prefix with '/api'

// Middleware
app.use(express.json()); // for parsing application/json

// Sample route
app.get('/', (req, res) => {
  res.send('API is running...');
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
