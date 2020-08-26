export default class GetReportsController {
  constructor() {}
  async execute(request, response, next) {
    try {
      const { Client } = require('pg');
      const client = new Client({
        connectionString: `${process.env.DATABASE_URL}`,
        ssl: process.env.DB_SSL ? true : false
      });

      await client.connect();
      const result = await client.query('select * from report');
      client.end();
      return response.json({ result });
    } catch (error) {
      return error;
    }
  }
}
