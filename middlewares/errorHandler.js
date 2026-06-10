// Gestore centralizzato degli errori: qualsiasi errore lanciato (o promise
// rifiutata) nei controller finisce qui grazie a Express 5.
function errorHandler(error, request, response, next) {
    console.error(error);

    response.status(500).json({ error: error.message });
}

export default errorHandler;
