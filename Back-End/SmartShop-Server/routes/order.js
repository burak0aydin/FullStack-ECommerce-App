const express = require('express')
const router = express.Router()
const orderController = require('../controllers/orderController');
const { body } = require('express-validator');

const validateCreateOrder = [
    body('total')
        .isFloat({ gt: 0 })
        .withMessage('total must be a positive number'),
    body('order_items')
        .isArray({ min: 1 })
        .withMessage('order items must be a non-empty array'),
    body('order_items.*.product_id')
        .isInt({ gt: 0 })
        .withMessage('Each order item must have a valid product id'),
    body('order_items.*.quantity')
        .isInt({ gt: 0 })
        .withMessage('Each order item must have a valid quantity greater than 0'),
    body('order_items').custom((items) => {
        if (!Array.isArray(items) || items.length === 0) {
            throw new Error('order_items must be a non-empty array');
        }
        items.forEach(item => {
            if(!item.product_id || !item.quantity) {
                throw new Error('Each order item must have a product_id and quantity');
            }
        })
        return true 
    })
]

// create a new order 
router.post('/create-order', validateCreateOrder, orderController.createOrder)

module.exports = router 