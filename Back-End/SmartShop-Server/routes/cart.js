const express = require('express')
const router = express.Router() 
const cartController = require('../controllers/cartController')

// Sepete ürün ekle 
router.post('/items', cartController.addCartItem)

//  Sepeti görüntüle
router.get('/', cartController.loadCart)

//  Sepetten ürün çıkar
// /api/cart/
router.delete('/item/:cartItemId', cartController.removeCartItem)

module.exports = router 