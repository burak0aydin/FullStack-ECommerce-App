const express = require('express')
const app = express()    // create an express app

app.use(express.json())  // enable parsing of JSON data

const movies = [
    { title: 'Jaws', genre: 'action' },
    { title: 'Avatar', genre: 'fiction' },
    { title: 'Brazil', genre: 'kids' }
]

app.get('/', (req, res) => {
    res.send('ROOT')
})

app.get('/hello', (req, res) => {
    res.json({ message: 'hello world' })
})

app.get('/movies', (req, res) => {
    res.json(movies)
})

app.post('/movies', (req, res) => {
    const { title, genre } = req.body
    res.send('OK')
})

app.get('/movies/:genre', (req, res) => {
    const genre = req.params.genre
    res.json(movies.filter(movie => movie.genre.toLowerCase() == genre.toLowerCase()))
})

app.get('/movies/:genre/year/:year', (req, res) => {
    const genre = req.params.genre
    const year = parseInt(req.params.year)
    res.send(`you selected ${genre} and the year is ${year}`)
})


//start the server
app.listen(8080, () => {
    console.log('Server is running on port 8080')
})