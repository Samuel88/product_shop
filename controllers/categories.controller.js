import db from '../db/connection.js';

async function index(request, response) {
    const [categories] = await db.query('SELECT * FROM categories');

    response.json(categories);
}

async function show(request, response) {
    const [categories] = await db.query(
        'SELECT * FROM categories WHERE id = ?',
        [request.params.id]
    );

    if (categories.length === 0) {
        return response.status(404).json({ error: 'Categoria non trovata' });
    }

    response.json(categories[0]);
}

async function destroy(request, response) {
    const [result] = await db.query(
        'DELETE FROM categories WHERE id = ?',
        [request.params.id]
    );

    if (result.affectedRows === 0) {
        return response.status(404).json({ error: 'Categoria non trovata' });
    }

    response.status(204).send();
}

export {
    index,
    show,
    destroy
}
