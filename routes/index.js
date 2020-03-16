import express from 'express';
import reportsRouter from './reports.router';
const routes = express.Router();

routes.use(reportsRouter);

export default routes;
