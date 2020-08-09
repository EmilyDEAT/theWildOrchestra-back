const pool = require('../conf')

module.exports = {
  async findOneById(idConcert) {
    const sql = `SELECT
      concert.id,
      DATE_FORMAT(date, "%Y-%m-%d") AS date,
      TIME_FORMAT(time, "%H:%i") AS time,
      location.concert_hall,
      concert.id_location AS id_location,
      concert.id_project AS id_project,
      city.name AS city,
      project.title AS project
      FROM concert
      JOIN location ON location.id = concert.id_location
      JOIN city ON city.id = location.id_city
      JOIN project ON project.id = concert.id_project
      WHERE concert.id = ?`
    const concerts = await pool.queryAsync(sql, idConcert)
    return concerts[0]
  }
}
