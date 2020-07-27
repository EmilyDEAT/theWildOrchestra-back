const express = require('express')
const connection = require('../conf')
const router = express.Router()
const multer  = require('multer')

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadsPath = 'uploads/'
    cb(null, uploadsPath)
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname)
  }
})

const fileFilter = (req, file, cb) => {
  // reject a file
  if (file.mimetype === 'image/jpeg' || file.mimetype === 'image/png') {
    cb(null, true)
  } else {
    cb(new Error('This type of file is not supported'), null, false)
  }
}

const upload = multer({
  storage: storage,
  fileFilter: fileFilter
})

router.get('/', (req, res) => {
  const sql = `SELECT musician.*, instrument.instrument
  FROM musician
  JOIN instrument ON instrument.id = musician.id_instrument
  ORDER BY instrument.id`
  connection.query(sql, (err, results) => {
    if (err) {
      res.status(500).send('Erreur lors de la récupération des musiciens')
    } else {
      res.status(200).send(results)
    }
  })
})

router.get('/:id', (req, res) => {
  const idMusician = req.params.id
  const sql = `SELECT musician.*, instrument.instrument
  FROM musician
  JOIN instrument ON instrument.id = musician.id_instrument
  WHERE musician.id = ?`
  connection.query(sql, idMusician, (err, results) => {
    if (err) {
      res.status(500).send("Erreur lors de la récupération du musicien")
    } else {
      res.status(200).send(results[0])
    }
  })
})
router.post('/', upload.single('photo'), (req, res) => {
  console.log(req.file)
   const sqlInsertPhoto = 'INSERT INTO musician (firstname, lastname, id_instrument, photo) VALUES (?,?,?,?)'
   const musicianData = [
    req.body.firstname,
    req.body.lastname,
    req.body.id_instrument,
    req.file.filename,
   ]
   connection.query(sqlInsertPhoto, musicianData, (err, stats) => {
     if (err) {
      res.status(500).send("Erreur lors de l'ajout d'un musicen'")
     } else {
      const sqlSelect = `SELECT * FROM musician WHERE id = ?`
      connection.query(sqlSelect, stats.insertId, (err, results) => {
        if (err) {
          res.status(500).send("Erreur lors de la récupération du musicien ajouté")
        } else {
          res.status(200).send(results[0])
        }
      })
     }   
   })
 })

router.put('/:id', (req, res) => {
  const idMusician = req.params.id
  const formData = req.body
  const sql = 'UPDATE musician SET ? WHERE id = ?'
  connection.query(sql, [formData, idMusician], (err, stats) => {
    if (err) {
      res.status(500).send("Erreur lors de la modification d'un musicien'")
    } else {
      const sqlSelect = `SELECT * FROM musician WHERE id = ?`
      connection.query(sqlSelect, idMusician, (err, results) => {
        if (err) {
          res.status(500).send("Erreur lors de la récupération du musicien modifié")
        } else {
          res.status(200).send(results[0])
        }
      })
    }
  })
})

router.delete('/:id', (req, res) => {
  const idMusician = req.params.id
  const sql = 'DELETE FROM musician WHERE id = ?'
  connection.query(sql, idMusician, (err, stats) => {
    if (err) {
      res.status(500).send("Erreur lors de la suppresion du musicien'")
    } else {
      res.sendStatus(204)
    }
  })
})

module.exports = router
