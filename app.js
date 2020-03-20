import express from 'express';
import volleyball from 'volleyball';
import routes from './routes/index';
import { environmentVariables } from './config/env';

let app = express();

app.use(volleyball);
app.use(routes);

export default app;
