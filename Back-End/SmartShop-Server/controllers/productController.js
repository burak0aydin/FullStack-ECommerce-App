
const models = require('../models')
const multer = require('multer')
const path = require('path')
const { validationResult } = require('express-validator');
const { getFileNameFromUrl, deleteFile } = require('../utils/fileUtils');
const redisService = require('../services/redisService');

// Redis cache keys
const CACHE_KEYS = {
  ALL_PRODUCTS: 'all_products',
  USER_PRODUCTS: (userId) => `user_products_${userId}`,
  PRODUCT_DETAIL: (productId) => `product_${productId}`
};

// configure multer for file storage 
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/')
    },
    filename: function (req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname))
    }
})

// setting up multer for image uploads 
const uploadImage = multer({
    storage: storage,
    limits: { fileSize: 5 * 1024 * 1024 },
    fileFilter: function (req, file, cb) {
        const fileTypes = /jpeg|jpg|png/;
        const extname = fileTypes.test(path.extname(file.originalname).toLowerCase())
        const mimeType = fileTypes.test(file.mimetype)

        if (mimeType && extname) {
            return cb(null, true)
        } else {
            cb(new Error('Only images are allowed!'))
        }
    }
}).single('image')


exports.upload = async (req, res) => {
    uploadImage(req, res, (err) => {
        if (err) {
            return res.status(400).json({ message: err.message, success: false });
        }
        if (!req.file) {
            return res.status(400).json({ message: 'No file uploaded', success: false });
        }

        const baseUrl = `${req.protocol}://${req.get('host')}`
        const filePath = `/api/uploads/${req.file.filename}`
        const downloadUrl = `${baseUrl}${filePath}`

        res.json({ message: 'File uploaded successfully', downloadUrl: downloadUrl, success: true })

    })
}

exports.getAllProducts = async (req, res) => {
    try {
        // 1. Check cache first
        const cachedProducts = await redisService.get(CACHE_KEYS.ALL_PRODUCTS);
        
        if (cachedProducts) {
            console.log('✅ Ürünler cache\'den alındı');
            return res.json(cachedProducts);
        }
        
        // 2. If not in cache, get from database
        console.log('🔍 Ürünler veritabanından alınıyor...');
        const products = await models.Product.findAll({});
        
        // 3. Store in cache for future requests (cache for 10 minutes)
        await redisService.set(CACHE_KEYS.ALL_PRODUCTS, products, 600);
        
        res.json(products);
    } catch (error) {
        console.error('❌ Ürünleri getirme hatası:', error);
        res.status(500).json({ 
            message: 'Error retrieving products', 
            success: false 
        });
    }
}

// /api/products/user/6
exports.getMyProducts = async (req, res) => {
    try {
        const userId = req.params.userId;
        
        // 1. Check cache first
        const cacheKey = CACHE_KEYS.USER_PRODUCTS(userId);
        const cachedProducts = await redisService.get(cacheKey);
        
        if (cachedProducts) {
            console.log(`✅ Kullanıcı ${userId} ürünleri cache'den alındı`);
            return res.json(cachedProducts);
        }
        
        // 2. If not in cache, get from database
        console.log(`🔍 Kullanıcı ${userId} ürünleri veritabanından alınıyor...`);
        const products = await models.Product.findAll({
            where: {
                user_id: userId
            }
        });
        
        // 3. Store in cache for future requests (cache for 5 minutes)
        await redisService.set(cacheKey, products, 300);
        
        res.json(products);
    } catch (error) {
        console.error('❌ Kullanıcı ürünlerini getirme hatası:', error);
        res.status(500).json({ 
            message: 'Error retrieving products', 
            success: false 
        });
    }
}

exports.create = async (req, res) => {
    const errors = validationResult(req)

    if (!errors.isEmpty()) {
        const msg = errors.array().map(error => error.msg).join('')
        return res.status(422).json({ message: msg, success: false });
    }

    const { name, description, price, photo_url, user_id } = req.body

    try {
        const newProduct = await models.Product.create({
            name: name,
            description: description,
            price: price,
            photo_url: photo_url,
            user_id: user_id
        })
        
        // Invalidate related caches when a new product is created
        await redisService.delete(CACHE_KEYS.ALL_PRODUCTS);
        await redisService.delete(CACHE_KEYS.USER_PRODUCTS(user_id));

        res.status(201).json({ success: true, product: newProduct })

    } catch (error) {
        res.status(500).json({ message: "Internal server error", success: false });
    }
}

exports.deleteProduct = async (req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        const msg = errors.array().map(error => error.msg).join('')
        return res.status(422).json({ message: msg, success: false });
    }

    const productId = req.params.productId

    try {
        const product = await models.Product.findByPk(productId)
        if (!product) {
            return res.status(404).json({ message: 'Product not found', success: false });
        }

        const fileName = getFileNameFromUrl(product.photo_url)

        // delete the product 
        const result = models.Product.destroy({
            where: {
                id: productId
            }
        })

        if (result == 0) {
            return res.status(404).json({ message: 'Product not found', success: false });
        }

        // delete the file 
        await deleteFile(fileName)
        
        // Invalidate related caches
        await redisService.delete(CACHE_KEYS.ALL_PRODUCTS);
        await redisService.delete(CACHE_KEYS.USER_PRODUCTS(product.user_id));
        await redisService.delete(CACHE_KEYS.PRODUCT_DETAIL(productId));

        return res.status(200).json({ message: `Product with ID ${productId} deleted successfully`, success: true });

    } catch (err) {
        return res.status(500).json({ message: `Error deleting product ${err.message} `, success: false });
    }
}

exports.updateProduct = async (req, res) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
        const msg = errors.array().map(error => error.msg).join('')
        return res.status(422).json({ message: msg, success: false });
    }

    try {
        const { name, description, price, photo_url, user_id } = req.body
        const { productId } = req.params 

        const product = await models.Product.findOne({
            where: {
                id: productId, 
                user_id: user_id
            }
        })

        console.log(product)

        if(!product) {
            return res.status(404).json({ message: 'Product not found', success: false });
        }

        // update the product 
        await product.update({
            name, 
            description, 
            price, 
            photo_url
        })
        
        // Invalidate related caches
        await redisService.delete(CACHE_KEYS.ALL_PRODUCTS);
        await redisService.delete(CACHE_KEYS.USER_PRODUCTS(user_id));
        await redisService.delete(CACHE_KEYS.PRODUCT_DETAIL(productId));

        return res.status(200).json({
            message: 'Product updated successfully', 
            success: true, 
            product 
        })
    } catch (err) {
        return res.status(500).json({
            message: 'An error occurred while updating the product',
            success: false
          });
    }
}
