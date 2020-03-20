import app from './app';
app.listen(process.env.PORT, () => console.log('context:', process.env.NODE_ENV));
