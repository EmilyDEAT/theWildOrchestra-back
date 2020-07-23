const express = require('express')
const connection = require('../conf')
const router = express.Router()

router.get('/', (req, res) => {
  const sql = `SELECT concert.id, DATE_FORMAT(date, "%W-%d-%m-%Y") AS date, TIME_FORMAT(time, "%H:%i") AS time, location.concert_hall, city.name AS city, project.title AS project
  FROM concert
  JOIN location ON location.id = concert.id_location
  JOIN city ON city.id = location.id_city
  JOIN project ON project.id = concert.id_project
  ORDER BY concert.date`
  connection.query(sql, (err, results) => {
    if (err) {
      res.status(500).send('Erreur lors de la récupération des concerts')
    } else {
      res.status(200).send(results)
    }
  })
})

router.get('/:id', (req, res) => {
  const idConcert = req.params.id
  const sql = `SELECT concert.id, DATE_FORMAT(date, "%Y-%m-%d") AS date, TIME_FORMAT(time, "%H:%i") AS time, location.concert_hall, concert.id_location AS id_location, concert.id_project AS id_project, city.name AS city, project.title AS project
  FROM concert
  JOIN location ON location.id = concert.id_location
  JOIN city ON city.id = location.id_city
  JOIN project ON project.id = concert.id_project
  WHERE concert.id = ?`
  connection.query(sql, idConcert, (err, results) => {
    if (err) {
      res.status(500).send("Erreur lors de la récupération du concert")
    } else {
      res.status(200).send(results[0])
    }
  })
})

router.post('/', (req, res) => {
  const formData = req.body
  const sql = 'INSERT INTO concert SET ?'
  connection.query(sql, formData, (err, stats) => {
    if (err) {
      res.status(500).send("Erreur lors de l'ajout d'un concert'")
    } else {
      const sqlSelect = `SELECT * FROM concert WHERE id = ?`
      connection.query(sqlSelect, stats.insertId, (err, results) => {
        if (err) {
          res.status(500).send("Erreur lors de la récupération du concert ajouté")
        } else {
          res.status(200).send(results[0])
        }
      })
    }
  })
})

router.put('/:id', (req, res) => {
  const idConcert = req.params.id
  const formData = req.body
  const sql = 'UPDATE concert SET ? WHERE id = ?'
  connection.query(sql, [formData, idConcert], (err, stats) => {
    if (err) {
      console.log(err)
      res.status(500).send("Erreur lors de la modification d'un concert'")
    } else {
      const sqlSelect = `SELECT * FROM concert WHERE id = ?`
      connection.query(sqlSelect, idConcert, (err, results) => {
        if (err) {
          res.status(500).send("Erreur lors de la récupération du concert modifié")
        } else {
          res.status(200).send(results[0])
        }
      })
    }
  })
})

router.delete('/:id', (req, res) => {
  const idConcert = req.params.id
  const sql = 'DELETE FROM concert WHERE id = ?'
  connection.query(sql, idConcert, (err, stats) => {
    if (err) {
      res.status(500).send("Erreur lors de la suppresion du concert'")
    } else {
      res.sendStatus(204)
    }
  })
})

module.exports = router
