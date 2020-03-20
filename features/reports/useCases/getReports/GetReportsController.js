export default class GetReportsController {
  constructor() {}
  async execute(request, response, next) {
    try {
      const { Client } = require('pg');
      const client = new Client({
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_DB,
        host: process.env.DB_HOST,
        port: process.env.DB_PORT
      });

      await client.connect();
      const result = await client.query('SELECT * FROM identities');
      client.end();
      response.sendStatus(200).json({ result });
    } catch (error) {
      return error;
    }
  }
}
