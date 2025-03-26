const express = require('express')
const router = express.Router() 
const cartController = require('../controllers/cartController')

router.post('/items', cartController.addCartItem)

// loadCart 
router.get('/', cartController.loadCart)

module.exports = router 