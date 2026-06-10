import db from '../db/connection.js';

// Campi della tabella reviews modificabili dal client
const FIELDS = ['product_id', 'name', 'rating', 'title', 'content'];

async function findById(id) {
    const [reviews] = await db.query('SELECT * FROM reviews WHERE id = ?', [id]);

    return reviews[0];
}

async function index(request, response) {
    const [reviews] = await db.query('SELECT * FROM reviews');

    response.json(reviews);
}

async function show(request, response) {
    const review = await findById(request.params.id);

    if (!review) {
        return response.status(404).json({ error: 'Review non trovata' });
    }

    response.json(review);
}

async function create(request, response) {
    const { product_id, name, rating, title, content } = request.body;

    const [result] = await db.query(
        `INSERT INTO reviews (product_id, name, rating, title, content)
         VALUES (?, ?, ?, ?, ?)`,
        [product_id, name, rating, title, content]
    );

    const review = await findById(result.insertId);

    response.status(201).json(review);
}

async function update(request, response) {
    const review = await findById(request.params.id);

    if (!review) {
        return response.status(404).json({ error: 'Review non trovata' });
    }

    // Aggiornamento parziale: consideriamo solo i campi della tabella
    // effettivamente presenti nel body.
    const fields = FIELDS.filter((field) => request.body?.[field] !== undefined);

    if (fields.length === 0) {
        return response.status(400).json({ error: 'Nessun campo valido da aggiornare' });
    }

    await db.query(
        `UPDATE reviews SET ${fields.map((field) => `${field} = ?`).join(', ')} WHERE id = ?`,
        [...fields.map((field) => request.body[field]), request.params.id]
    );

    response.json(await findById(request.params.id));
}

async function destroy(request, response) {
    const [result] = await db.query(
        'DELETE FROM reviews WHERE id = ?',
        [request.params.id]
    );

    if (result.affectedRows === 0) {
        return response.status(404).json({ error: 'Review non trovata' });
    }

    response.json({ message: 'Review eliminata' });
}

export {
    index,
    show,
    create,
    update,
    destroy
}
