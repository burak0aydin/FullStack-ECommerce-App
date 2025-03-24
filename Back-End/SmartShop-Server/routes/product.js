const express = require('express')
const router = express.Router() 
const productController = require('../controllers/productController') 
const { body } = require('express-validator');

const productValidator = [
    body('name', 'name cannot be empty.').not().isEmpty(), 
    body('description', 'description cannot be empty.').not().isEmpty(), 
    body('price', 'price cannot be empty.').not().isEmpty(), 
    body('photo_url')
    .notEmpty().withMessage('photoUrl cannot be empty.')
]

// /api/products
router.get('/', productController.getAllProducts)
router.post('/', productValidator, productController.create)

module.exports = router 