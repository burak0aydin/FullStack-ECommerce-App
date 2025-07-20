const express = require('express')
const router = express.Router() 
const productController = require('../controllers/productController') 
const authenticate = require('../middlewares/authMiddleware');
const { productValidator, deleteProductValidator, updateProductValidator } = require('../validators/validators')

// Tüm ürünleri listele
router.get('/', productController.getAllProducts)
// Ürün detaylarını getir
router.post('/', authenticate, productValidator, productController.create)
// Kullanıcının ürünlerini getir
router.get('/user/:userId', authenticate, productController.getMyProducts)
// Ürün yükle
router.post('/upload', authenticate, productController.upload)

// Ürün sil
router.delete('/:productId', authenticate, deleteProductValidator, productController.deleteProduct)

// Ürünü güncelle 
router.put('/:productId', authenticate, updateProductValidator, productController.updateProduct)

module.exports = router 