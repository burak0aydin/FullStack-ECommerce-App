const express = require('express')
const models = require('./models')
const app = express()    // create an express app

// JSON parser
app.use(express.json())

app.post('/register', (req, res) => {
    const { username, password } = req.body

    //create a new user
    const newUser = models.User.create({
        username: username,
        password: password
    })

    res.status(201).json({ succes: true })
})

//start the server
app.listen(8080, () => {
    console.log('Server is running on port 8080')
})