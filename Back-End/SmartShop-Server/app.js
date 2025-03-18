const express = require('express')
const models = require('./models')
const { Op } = require('sequelize');
const bcrypt = require('bcryptjs')
const { body, validationResult } = require('express-validator');
const app = express()

// JSON parser 
app.use(express.json())

const registerValidator = [
    body('username', 'username cannot be empty!').not().isEmpty(),
    body('password', 'password cannot be empty.').not().isEmpty()
]

app.post('/register', registerValidator, async (req, res) => {

    const errors = validationResult(req)
    if (!errors.isEmpty()) {
        const msg = errors.array().map(error => error.msg).join('')
        return res.status(422).json({ success: false, message: msg })
    }

    try {
        const { username, password } = req.body

        const existingUser = await models.User.findOne({
            where: {
                username: { [Op.iLike]: username }
            }
        })

        if (existingUser) {
            return res.json({ message: 'Username taken!', success: false })
        }

        // create a password hash 
        const salt = await bcrypt.genSalt(10)
        const hash = await bcrypt.hash(password, salt)

        // create a new user 
        const _ = models.User.create({
            username: username,
            password: hash
        })

        res.status(201).json({ success: true })
    } catch (error) {
        res.status(500).json({ message: 'Internal server error.', success: false })
    }

})

// start the server 
app.listen(8080, () => {
    console.log('Server is running.')
})