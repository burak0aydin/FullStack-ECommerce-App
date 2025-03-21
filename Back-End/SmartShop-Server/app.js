const express = require('express')
const cors = require('cors')

const authRoutes = require('./routes/auth')

const app = express()

// CORS
app.use(cors())

// JSON parser 
app.use(express.json())
// register our routers
app.use('/api/auth', authRoutes)

// start the server 
app.listen(8080, () => {
    console.log('Server is running.')
})