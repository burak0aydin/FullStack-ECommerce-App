const { body } = require('express-validator');
const { param } = require('express-validator');

// Product Validators

const productValidator = [
    body('name', 'name cannot be empty.').not().isEmpty(), 
    body('description', 'description cannot be empty.').not().isEmpty(), 
    body('price', 'price cannot be empty.').not().isEmpty(), 
    body('photo_url')
    .notEmpty().withMessage('photoUrl cannot be empty.')
]

const deleteProductValidator = [
    param('productId')
    .notEmpty().withMessage('ProductId is required.')
    .isNumeric().withMessage('Product Id must be a number')
]

const updateProductValidator = [
    param('productId')
    .notEmpty().withMessage('ProductId is required.')
    .isNumeric().withMessage('Product Id must be a number'), 
    body('name', 'name cannot be empty.').not().isEmpty(), 
    body('description', 'description cannot be empty.').not().isEmpty(), 
    body('price', 'price cannot be empty.').not().isEmpty(), 
    body('photo_url')
    .notEmpty().withMessage('photoUrl cannot be empty.'), 
    body('user_id')
    .notEmpty().withMessage('UserId is required.')
    .isNumeric().withMessage('UserId must be a number'), 
]

// User Validators 

const updateUserInfoValidator = [
    body('first_name', 'First name cannot be empty.').notEmpty(),
    body('last_name', 'Last name cannot be empty.').notEmpty(),
    body('street', 'Street cannot be empty.').notEmpty(),
    body('city', 'City cannot be empty.').notEmpty(),
    body('state', 'State cannot be empty.').notEmpty(),
    body('zip_code', 'Zip code cannot be empty.').notEmpty(),
    body('country', 'Country cannot be empty.').notEmpty()
]

// Order Validators 

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

// Authentication Validators 

const registerValidator = [
    body('username', 'username cannot be empty!').not().isEmpty(),
    body('password', 'password cannot be empty.').not().isEmpty()
]

const loginValidator = [
    body('username', 'username cannot be empty.').not().isEmpty(), 
    body('password', 'password cannot be empty.').not().isEmpty()  
]

module.exports = {
    productValidator, 
    deleteProductValidator, 
    updateProductValidator, 
    updateUserInfoValidator, 
    validateCreateOrder, 
    registerValidator, 
    loginValidator
}