// Middleware "catch-all": gestisce tutte le richieste che non hanno
// trovato una rotta corrispondente.
function notFound(request, response, next) {
    response.status(404).json({ error: 'Not Found' });
}

export default notFound;
