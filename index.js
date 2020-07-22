require('dotenv').config()
const express = require('express')
const cors = require('cors')
const app = express()
const routes = require('./src/routes/index')

app.use(express.json())
app.use(
  express.urlencoded({
    extended: true
  })
)
app.use(cors())

app.use('/api/concerts', routes.Concerts)
app.use('/api/musicians', routes.Musicians)

app.listen(8000, (err) => {
  if (err) {
    throw new Error('Something bad just happened...')
  }
  console.log(`Server is listening on 8000`)
})