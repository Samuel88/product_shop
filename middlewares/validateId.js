import db from '../db/connection.js';

async function validateId(request, response, next) {
    const id = Number(request.params.id);

    if (!Number.isInteger(id) || id < 1) {
        return response.status(404).json({ error: 'Not Found' });
    }

    const [products] = await db.query(
        'SELECT * FROM products WHERE id = ?',
        [id]
    );

    if (products.length === 0) {
        return response.status(404).json({ error: 'Not Found' });
    }

    request.product = products[0];

    next();
}

export default validateId;
