import express from 'express';
import productsRouter from './routers/products.router.js';
import categoriesRouter from './routers/categories.router.js';
import reviewsRouter from './routers/reviews.router.js';
import notFound from './middlewares/notFound.js';
import errorHandler from './middlewares/errorHandler.js';

const app = express();

app.use(express.json());

app.use('/products', productsRouter);
app.use('/categories', categoriesRouter);
app.use('/reviews', reviewsRouter);

app.use(notFound);
app.use(errorHandler);

export default app;
