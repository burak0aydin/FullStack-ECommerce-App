const express = require('express')
const router = express.Router()
const orderController = require('../controllers/orderController');
const { validateCreateOrder } = require('../validators/validators')


// Sipariş oluştur
router.post('/create-order', validateCreateOrder, orderController.createOrder)

module.exports = router 