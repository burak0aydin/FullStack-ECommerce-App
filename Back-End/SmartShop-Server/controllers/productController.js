
const models = require('../models')
const multer = require('multer')
const path =  require('path')
const { validationResult } = require('express-validator');

// configure multer for file storage 
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, 'uploads/')
    }, 
    filename: function(req, file, cb) {
        cb(null, file.fieldname + '-' + Date().now() + path.extname(file.originalname))
    }
})

// setting up multer for image uploads 
const uploadImage = multer({
    storage: storage, 
    limits: { fileSize: 5 * 1024 * 1024 }, 
    fileFilter: function(req, file, cb) {
        const fileTypes = /jpeg|jpg|png/;
        const extname = fileTypes.test(path.extname(file.originalname).toLowerCase())
        const mimeType = fileTypes.test(file.mimetype)

        if(mimeType && extname) {
            return cb(null, true)
        } else {
            cb(new Error('Only images are allowed!'))
        }
    }
}).single('image')

exports.getAllProducts = async (req, res) => {
    const products = await models.Product.findAll({})
    res.json(products)
}

// /api/products/user/6
exports.getMyProducts = async (req, res) => {

    try {
        const userId = req.params.userId
        const products = await models.Product.findAll({
            where: {
                user_id: userId 
            }
        })

        res.json(products)

    } catch (error) {
        res.status(500).json({ message: 'Error retrieving products', success: false });
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

        res.status(201).json({ success: true, product: newProduct })

    } catch (error) {
        res.status(500).json({ message: "Internal server error", success: false });
    }
}


