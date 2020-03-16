import express from 'express';
import { getReportsController } from '../features/reports/useCases/getReports/index';
const reportsRouter = express.Router();

reportsRouter.get('/', (req, res, next) => {
  res.send('welcome to microci test!');
});

reportsRouter.get('/reports/:id', (req, res, next) => {
  getReportsController.execute(req, res, next);
});

export default reportsRouter;
