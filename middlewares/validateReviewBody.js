// Valida il body JSON per la creazione di una review: tutti i campi
// della tabella sono obbligatori.
function validateReviewBody(request, response, next) {
    const { product_id, name, rating, title, content } = request.body ?? {};

    const errors = [];

    if (!Number.isInteger(product_id) || product_id < 1) {
        errors.push('product_id deve essere un intero positivo');
    }
    if (typeof name !== 'string' || name.trim() === '') {
        errors.push('name è obbligatorio');
    }
    if (!Number.isInteger(rating) || rating < 1 || rating > 5) {
        errors.push('rating deve essere un intero tra 1 e 5');
    }
    if (typeof title !== 'string' || title.trim() === '') {
        errors.push('title è obbligatorio');
    }
    if (typeof content !== 'string' || content.trim() === '') {
        errors.push('content è obbligatorio');
    }

    if (errors.length > 0) {
        return response.status(400).json({ errors });
    }

    next();
}

export default validateReviewBody;
