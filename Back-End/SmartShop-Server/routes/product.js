const express = require('express')
const router = express.Router() 
const productController = require('../controllers/productController') 
const { body, param } = require('express-validator');
const authenticate = require('../middlewares/authMiddleware');

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

// /api/products
router.get('/', productController.getAllProducts)
router.post('/', authenticate, productValidator, productController.create)
// /api/products/user/6
router.get('/user/:userId', authenticate, productController.getMyProducts)

router.post('/upload', authenticate, productController.upload)

// DELETE /api/products/34
router.delete('/:productId', authenticate, deleteProductValidator, productController.deleteProduct)

// PUT 
router.put('/:productId', authenticate, updateProductValidator, productController.updateProduct)

module.exports = router  