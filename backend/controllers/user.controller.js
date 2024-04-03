// controllers/userController.js
const bcrypt = require('bcrypt');
const User = require('../models/user.model');

exports.registerUser = async (req, res) => {
  try {
    const { username, email, password } = req.body;
    console.log('req.body:', req.body)

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create a new user
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
