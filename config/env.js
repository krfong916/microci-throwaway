import dotenv from 'dotenv';
const path = require('path');

export const environmentVariables = dotenv.config({
  path: path.join(__dirname, `${process.env.NODE_ENVIRONMENT}.env`)
});
