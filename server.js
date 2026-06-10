import express from 'express';
import productsRouter from './routers/products.router.js';
import categoriesRouter from './routers/categories.router.js';

const PORT = process.env.SERVER_PORT;

const app = express();

app.use('/products', productsRouter);
app.use('/categories', categoriesRouter);

app.listen(PORT, (error) => {
    if (error) {
        console.error(error);
    } else {
        console.log(`Server in ascolto sulla port ${PORT}`);
    }
});