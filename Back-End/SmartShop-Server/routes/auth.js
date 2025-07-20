const express = require('express')
const router = express.Router() 
const authController = require('../controllers/authController') 
const { registerValidator, loginValidator } = require('../validators/validators')

//Kullanıcı kaydı
router.post('/register', registerValidator, authController.register)

//Kullanıcı girişi
router.post('/login', loginValidator, authController.login)

module.exports = router 