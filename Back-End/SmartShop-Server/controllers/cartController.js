
const models = require('../models')

exports.removeCartItem = async (req, res) => {

    try {

        const { cartItemId } = req.params 

        const deletedItem = await models.CartItem.destroy({
            where: {
                id: cartItemId
            }
        })

        if(!deletedItem) {
            return res.status(404).json({ message: 'Cart item not found', success: false });
        }

        res.status(200).json({ success: true });

    } catch (error) {
        res.status(500).json({ message: 'An error occurred while removing the cart item', success: false });
    }

}


exports.loadCart = async (req, res) => {

    try {

        const cart = await models.Cart.findOne({
            where: {
                user_id: 6, // MAKE SURE TO CHANGE THAT to request.userId
                is_active: true
            }, 
            attributes: ['id', 'user_id', 'is_active'], 
            include: [
                {
                    model: models.CartItem, 
                    as: 'cartItems', 
                    attributes: ['id', 'cart_id', 'product_id', 'quantity'], 
                    include: [
                        {
                            model: models.Product,
                            as: 'product', 
                            attributes: ['id', 'name', 'description', 'price', 'photo_url', 'user_id'] 
                        }
                    ]
                }
            ]
        })

        res.status(200).json({ cart: cart, success: true })

    } catch (error) {
        res.status(500).json({ message: error, success: false });
    }

}

exports.addCartItem = async (req, res) => {

    const { productId, quantity } = req.body 

    req.userId = 6 // MAKE SURE TO CHANGE THAT to request.userId

    try {

        // get the cart based on userId is_active: true 
        let cart = await models.Cart.findOne({
            where: {
                user_id: req.userId, 
                is_active: true 
            }
        })

        if(!cart) {
            // create a new cart 
            cart = models.Cart.create({
                user_id: req.userId, 
                is_active: true 
            })
        }

        // add item to the cart 
        const [cartItem, created] = await models.CartItem.findOrCreate({
            where: {
                cart_id: cart.id, 
                product_id: productId 
            }, 
            defaults: { quantity }
        })

        console.log(cartItem)

        if(!created) {
            // already exists 
            cartItem.quantity += quantity 
            // save it 
            await cartItem.save()
        }

        // get cartItem with product 
        const cartItemWithProduct = await models.CartItem.findOne({
            where: {
                id: cartItem.id 
            }, 
            attributes: ['id', 'cart_id', 'product_id', 'quantity'], 
            include: [
                {
                    model: models.Product, 
                    as: 'product', 
                    attributes: ['id', 'name', 'description', 'price', 'photo_url', 'user_id']
                }
            ]
        })

        res.status(201).json({
            message: 'Item added to the cart.', 
            success: true, 
            cartItem: cartItemWithProduct
        })

    } catch (error) {
        console.log(error)
        res.status(500).json({ message: 'Internal server error', success: false });
    }
}