// routes/userRoutes.js
const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');

router.post('/register', userController.registerUser);

router.post('/login', userController.loginUser);

router.get('/searchJobs',userController.webScrapoping);

module.exports = router;
