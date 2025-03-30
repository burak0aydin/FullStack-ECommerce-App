const express = require('express')
const cors = require('cors')

const authRoutes = require('./routes/auth')
const productRoutes = require('./routes/product')
const cartRoutes = require('./routes/cart') 
const userRoutes = require('./routes/user')
const orderRoutes = require('./routes/order')

const authenticate = require('./middlewares/authMiddleware')

const app = express()

app.use('/api/uploads',express.static('uploads'))

// CORS 
app.use(cors())
// JSON parser 
app.use(express.json())

// register our routers 
app.use('/api/auth', authRoutes)

// product routes 
app.use('/api/products', productRoutes)

// cart routes 
app.use('/api/cart', authenticate, cartRoutes)

// user routes 
app.use('/api/user', authenticate, userRoutes)

// order routes 
app.use('/api/orders', authenticate, orderRoutes)

// start the server 
app.listen(8080, () => {
    console.log('Server is running.')
})