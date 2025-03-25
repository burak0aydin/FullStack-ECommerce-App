const express = require('express')
const router = express.Router() 
const productController = require('../controllers/productController') 
const { body, param } = require('express-validator');

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

// /api/products
router.get('/', productController.getAllProducts)
router.post('/', productValidator, productController.create)
// /api/products/user/6
router.get('/user/:userId', productController.getMyProducts)

router.post('/upload', productController.upload)

// DELETE /api/products/34
router.delete('/:productId', deleteProductValidator, productController.deleteProduct)

module.exports = router 