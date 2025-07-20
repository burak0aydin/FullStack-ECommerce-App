const express = require('express');
const router = express.Router();
const { updateUserInfoValidator } = require('../validators/validators')

const userController = require('../controllers/userController')

// Kullanıcı bilgilerini güncelle
router.put('/',updateUserInfoValidator, userController.updateUserInfo)
// Kullanıcı bilgilerini yükle
router.get('/', userController.loadUserInfo)

module.exports = router 