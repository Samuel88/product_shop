import { HumanMessage, SystemMessage } from 'langchain';
import genericAgent from '../ai/agents/generic.agent.js';
import connection from '../db/connection.js';
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

async function reviewSummary(request, response) {

    const { product } = request;

    const [reviewRows] = await connection.execute(`
        SELECT *
        FROM reviews r
        WHERE r.product_id = ?
        `, [product.id]);


    const reviewsText = (reviewRows.length > 0) ? reviewRows.map(review => {
        return `---
Recensione #${review.id}
Autore: ${review.name}
Voto: ${review.rating}/5
Titolo: ${review.title}
Contenuto:
${review.content}
`
    }) : 'Nessuna recensione esistente';

    const aiResponse = await genericAgent.invoke({
        messages: [
            new SystemMessage(`
Sei un assistente che analizza le recensioni per un prodotto.
Genera un breve riassunto promozionale del prodotto usando queste recensioni

## Istruzioni
- Scrivi in italiano
- Usa un tono coinvolgente ma semplice
- Riassumi i punti forti emersi dalle recensioni
- Se non ci sono recensioni, di che non sono presenti relazioni
- Massimo 120 parole
            `),
            new HumanMessage(`
## Prodotto
Nome: ${product.name}
Prezzo: ${product.price}
Descrizione:
${product.description}

## Recensioni
${reviewsText}    
                
            `)
        ]
    });

    const responseText = aiResponse.messages.at(-1).content;

    return response.json({
        error: null,
        result: responseText
    });
}

async function reviewSummaryWithTools(request, response) {
    const { product } = request;

    const aiResponse = await genericAgent.invoke({
        messages: [
            new HumanMessage(`
Devi scrivere un breve testo promozionale in italiano per un prodotto del negozio Pulp Fiction.

Per rispondere:
1. recupera le recensioni del prodotto usando l'id "${product.id}"
2. Usa quelle positive per capire i punti di forza
3. Usa le recensioni negative per capire dove migliorare
4. Riassumi ciò che hai appreso
            `)
        ]
    });

    const responseText = aiResponse.messages.at(-1).content;

    return response.json({
        error: null,
        result: responseText
    });
}

export {
    index,
    show,
    destroy,
    reviewSummary,
    reviewSummaryWithTools
}
