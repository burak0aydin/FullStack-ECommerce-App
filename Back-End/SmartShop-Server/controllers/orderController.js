const { validationResult } = require('express-validator')
const models = require('../models')
const cartController = require('./cartController')

exports.createOrder = async (req, res) => {
    
    const errors = validationResult(req)
    
    if (!errors.isEmpty()) {
        const msg = errors.array().map(error => error.msg).join('')
        return res.status(422).json({ message: msg, success: false });
    }

    const userId = req.userId 
    const { total, order_items } = req.body 

    // start a transaction 
    const transaction = await models.Order.sequelize.transaction() 

    try {

        // create a new order 
        const newOrder = await models.Order.create({
            user_id: userId, 
            total: total
        }, { transaction }) // ensures that this is part of the transaction 

        // create order items with order id 
        const orderItemsData = order_items.map(item => ({
            product_id: item.product_id, 
            quantity: item.quantity, 
            order_id: newOrder.id 
        }))

        await models.OrderItem.bulkCreate(orderItemsData, { transaction })

        // get the active cart for the user 
        const cart = await models.Cart.findOne({
            where: {
                user_id: userId, 
                is_active: true 
            }, 
            attributes: ['id']
        })

        // update cart status to make it active = false 
        await cartController.updateCartStatus(cart.id, false, transaction)

        // clear cart items from cart items table 
        await cartController.removeCartItems(cart.id, transaction)

        // commit the transaction 
        await transaction.commit() 

        return res.status(201).json({ success: true });

    } catch (error) {
        console.log(error)
        // rollback the transaction 
        transaction.rollback() 
        return res.status(500).json({ message: 'Internal server error', success: false });
    }

}