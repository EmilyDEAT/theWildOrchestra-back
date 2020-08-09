const mysql = require('mysql')
const { promisify } = require('util')
require('dotenv').config()

const pool = mysql.createPool({
  host: process.env.SQL_HOST,
  user: process.env.SQL_USER,
  password: process.env.SQL_PASSWORD,
  database: process.env.SQL_NAME
})

pool.queryAsync = promisify(pool.query.bind(pool))

module.exports = pool
