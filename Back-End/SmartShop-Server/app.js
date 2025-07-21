const express = require('express')
const cors = require('cors')

const authRoutes = require('./routes/auth')
const productRoutes = require('./routes/product')
const cartRoutes = require('./routes/cart') 
const userRoutes = require('./routes/user')
const orderRoutes = require('./routes/order')
const paymentRoutes = require('./routes/payment')

const authenticate = require('./middlewares/authMiddleware')
const notificationService = require('./services/notificationService')
const redisService = require('./services/redisService')

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

// payment routes 
app.use('/api/payment', authenticate, paymentRoutes)

// start the server 
const PORT = process.env.PORT || 8080;
const HOST = process.env.HOST || '0.0.0.0';

// Test ortamında değilse sunucuyu başlat
if (process.env.NODE_ENV !== 'test') {
    app.listen(PORT, HOST, async () => {
        console.log(`Server is running on http://${HOST}:${PORT}`);
        console.log(`Network access: http://192.168.1.39:${PORT}`);
        
        // 🚀 RabbitMQ bağlantısını başlat
        console.log('🎯 RabbitMQ bağlantısı kuruluyor...');
        await notificationService.connect();
        
        // 🚀 Redis bağlantısını başlat
        await redisService.connect();
    })
}

// Export app for testing
module.exports = app;