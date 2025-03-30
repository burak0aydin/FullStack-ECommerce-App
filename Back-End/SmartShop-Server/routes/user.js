const express = require('express');
const router = express.Router();
const { updateUserInfoValidator } = require('../validators/validators')

const userController = require('../controllers/userController')

router.put('/',updateUserInfoValidator, userController.updateUserInfo)
router.get('/', userController.loadUserInfo)

module.exports = router 