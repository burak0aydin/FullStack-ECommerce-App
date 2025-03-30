const express = require('express')
const router = express.Router() 
const authController = require('../controllers/authController') 
const { registerValidator, loginValidator } = require('../validators/validators')

router.post('/register', registerValidator, authController.register)
router.post('/login', loginValidator, authController.login)

module.exports = router 