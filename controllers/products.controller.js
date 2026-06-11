import db from '../db/connection.js';

async function index(request, response) {
    const [products] = await db.query('SELECT * FROM products');

    response.json(products);
}

async function show(request, response) {
    const [products] = await db.query(
        'SELECT * FROM products WHERE id = ?',
        [request.params.id]
    );

    if (products.length === 0) {
        return response.status(404).json({ error: 'Prodotto non trovato' });
    }

    response.json(products[0]);
}

async function destroy(request, response) {
    const [result] = await db.query(
        'DELETE FROM products WHERE id = ?',
        [request.params.id]
    );

    if (result.affectedRows === 0) {
        return response.status(404).json({ error: 'Prodotto non trovato' });
    }

    response.json({ message: 'Prodotto eliminato' });
}

export {
    index,
    show,
    destroy
}
