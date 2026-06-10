// Valida il parametro :id della rotta: deve essere un intero positivo.
// Se non lo è, la risorsa non può esistere, quindi rispondiamo 404.
function validateId(request, response, next) {
    const id = Number(request.params.id);

    if (!Number.isInteger(id) || id < 1) {
        return response.status(404).json({ error: 'Not Found' });
    }

    next();
}

export default validateId;
