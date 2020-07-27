const express = require('express')
const connection = require('../conf')
const router = express.Router()

router.get('/', (req, res) => {
  const sql = `SELECT * FROM instrument`
  connection.query(sql, (err, results) => {
    if (err) {
      console.log(err)
      res.status(500).send('Erreur lors de la récupération des instruemntts')
    } else {
      res.status(200).send(results)
    }
  })
})

module.exports = router
