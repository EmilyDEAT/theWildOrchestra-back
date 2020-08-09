const express = require('express')
const connection = require('../conf')
const loggers = require('../helpers/loggers')
const concertModel = require('../models/concert')
const router = express.Router()

router.get('/', (req, res) => {
  const sql = `SELECT
    concert.id,
    DATE_FORMAT(date, "%Y-%m-%d") AS date,
    TIME_FORMAT(time, "%H:%i") AS time,
    location.concert_hall,
    city.name AS city,
    project.title AS project
  FROM concert
  JOIN location ON location.id = concert.id_location
  JOIN city ON city.id = location.id_city
  JOIN project ON project.id = concert.id_project
  ORDER BY concert.date`
  connection.query(sql, (err, results) => {
    if (err) {
      loggers.mysql(err.message)
      res.status(500).send('Erreur lors de la récupération des concerts')
    } else {
      res.status(200).send(results)
    }
  })
})

router.get('/:id', async (req, res) => {
  const idConcert = req.params.id
  try {
    const concert = await concertModel.findOneById(idConcert)
    res.status(200).send(concert)
  } catch (err) {
    res.status(500).send('Erreur lors de la récupération du concert')
  }
})

router.post('/', async (req, res) => {
  const formData = req.body
  try {
    const sql = 'INSERT INTO concert SET ?'
    const stats = await connection.queryAsync(sql, formData)
    const concert = await concertModel.findOneById(stats.insertId)
    res.status(200).send(concert)
  } catch (err) {
    loggers.mysql(err.message)
    res.status(500).send("Erreur lors de l'ajout d'un concert'")
  }
})

router.put('/:id', async (req, res) => {
  const idConcert = req.params.id
  const formData = req.body
  const sql = 'UPDATE concert SET ? WHERE id = ?'
  try {
    await connection.queryAsync(sql, [formData, idConcert])
    const concert = await concertModel.findOneById(idConcert)
    res.status(200).send(concert)
  } catch (err) {
    console.log(err)
    res.status(500).send("Erreur lors de la modification d'un concert'")
  }
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
