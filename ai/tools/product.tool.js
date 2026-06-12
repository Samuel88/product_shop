import { z } from 'zod';
import { tool } from 'langchain';
import connection from '../../db/connection.js';


const getReviewsByProductId = tool(
    async ({ productId }) => {
        console.log('Chiamo il tool getReviewsByProductId');
        

        const query = `
SELECT id, name, rating, content
FROM reviews r
WHERE r.product_id = ?
        `;

        const [reviewRows] = await connection.execute(query, [productId]);
        
        return JSON.stringify({
            count: reviewRows.length,
            reviewRows
        });
    },
    {
        name: "getReviewsByProductId",
        description: "Recupera le recensioni associate a un prodotto",
        schema: z.object({
            productId: z.number().describe("L'id del prodotto")
        })
    }
);

export {
    getReviewsByProductId
}