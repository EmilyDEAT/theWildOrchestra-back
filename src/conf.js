const mysql = require('mysql')
require('dotenv').config()
const loggers = require('./helpers/loggers')

const connection = mysql.createConnection({
  host: process.env.SQL_HOST,
  user: process.env.SQL_USER,
  password: process.env.SQL_PASSWORD,
  database: process.env.SQL_NAME
})

connection.connect(err => {
  if (err) throw err
  loggers.mysql('connected !')
})

module.exports = connection