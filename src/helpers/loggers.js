const debug = require('debug')

const mysql = debug('mysql')
const express = debug('express')

module.exports = {
  mysql,
  express
}