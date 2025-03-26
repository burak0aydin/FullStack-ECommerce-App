const express = require('express')
const router = express.Router() 
const cartController = require('../controllers/cartController')

// addCartItem  
router.post('/items', cartController.addCartItem)

// loadCart 
router.get('/', cartController.loadCart)

// delete cart item 
// /api/cart/
router.delete('/item/:cartItemId', cartController.removeCartItem)

module.exports = router 