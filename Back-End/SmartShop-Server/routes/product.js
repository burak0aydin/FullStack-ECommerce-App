const express = require('express')
const router = express.Router() 
const productController = require('../controllers/productController') 
const authenticate = require('../middlewares/authMiddleware');
const { productValidator, deleteProductValidator, updateProductValidator } = require('../validators/validators')

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