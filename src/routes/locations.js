const express = require('express')
const connection = require('../conf')
const router = express.Router()

router.get('/', (req, res) => {
  const city = req.query.city
  const sql = `SELECT location.*, city.name FROM location
  JOIN city ON city.id = location.id_city 
  ${city ? 'WHERE city.name=?' : ''} `
  connection.query(sql, city, (err, results) => {
    if (err) {
      console.log(err)
      res.status(500).send('Erreur lors de la récupération des lieux')
    } else {
      res.status(200).send(results)
    }
  })
})

module.exports = router
