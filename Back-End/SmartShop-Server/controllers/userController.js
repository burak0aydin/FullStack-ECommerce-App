const models = require('../models')

exports.updateUserInfo = async (req, res) => {

    try {
        
        console.log(req.body)
        const userId = req.userId 
        const { first_name, last_name, street, city, state, zip_code, country } = req.body 

        // find the user 
        const userInfo = await models.User.findByPk(userId, {
            attributes: ['id', 'first_name', 'last_name', 'street', 'city', 'state', 'zip_code', 'country']
        })

        if(!userInfo) {
            return res.status(404).json({ message: 'User not found.', success: false });
        }

        await userInfo.update({
            first_name,
            last_name,
            street,
            city,
            state,
            zip_code, 
            country
        })

        return res.status(200).json({
            message: 'User updated successfully',
            success: true,
            userInfo
        });

    } catch (error) {
        return res.status(500).json({
            message: 'An error occurred while updating the user',
            success: false
        });
    }

}