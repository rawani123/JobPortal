// controllers/userController.js
const bcrypt = require('bcrypt');
const User = require('../models/user.model');
const axios = require('axios');

exports.registerUser = async (req, res) => {
  try {
    const { username, email, password } = req.body;
    console.log('req.body:', req.body)

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

//     Create a new user
     const newUser = new User({
       username,
       email,
       password: hashedPassword,
     });

    // Save the user to the database
    await newUser.save();

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    console.error('Error registering user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const jwt = require('jsonwebtoken');

exports.loginUser = async (req, res) => {
  try {
    // Extract username and password from the request body
    const { username, password } = req.body;
    console.log("Api called")
    console.log(req.body)

    // Find the user by username
    const user = await User.findOne({ username });

    if (!user) {
      // User not found or invalid credentials
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    // Compare passwords
    const comparePassword = await bcrypt.compare(password, user.password);

    if (!comparePassword) {
      // Invalid password
      return res.status(401).json({ error: 'Invalid credentials' });
    }

    // Generate JWT token
    const token = jwt.sign(
      { userId: user._id, username: user.username },
      "asbfbafbgakdsakg", // Use a secret key for signing the token
      { expiresIn: '1h' } // Token expiry time
    );

    // Send JWT token to client
    res.status(200).json({ message: 'Login successful', token });
  } catch (error) {
    // Handle any errors
    console.error('Error logging in user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
};

exports.webScrapoping = async (req,res )=>{
 const options = {
    method: 'GET',
    url: 'https://linkedin-data-scraper.p.rapidapi.com/search_jobs',
    params: {
      query: 'Software developer',
      location: 'India',
      page: '1'
    },
    headers: {
      'X-RapidAPI-Key': '7a58a188a3mshfabb492a690ceedp1bd3e8jsnc244c871b93b',
      'X-RapidAPI-Host': 'linkedin-data-scraper.p.rapidapi.com'
    }
  };

  try {
    const response = await axios.request(options);
    console.log("Called APi")
    res.json(response.data); // Send the job search results as response
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }}