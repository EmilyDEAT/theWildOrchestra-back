require('dotenv').config()
const express = require('express')
const cors = require('cors')
const app = express()
const routes = require('./src/routes/index')
const loggers = require('./src/helpers/loggers')

app.use(express.json())
app.use(
  express.urlencoded({
    extended: true
  })
)
app.use(cors())
app.use(express.static('uploads'))

app.use('/api/cities', routes.Cities)
app.use('/api/concerts', routes.Concerts)
app.use('/api/instruments', routes.Instruments)
app.use('/api/locations', routes.Locations)
app.use('/api/musicians', routes.Musicians)
app.use('/api/projects', routes.Projects)

app.listen(8000, (err) => {
  if (err) {
    loggers.express('ERROR', err.message)
    throw new Error('Something bad just happened...')
  }
  loggers.express(`Server is listening on 8000`)
})