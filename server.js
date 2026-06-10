import app from './app.js';

const PORT = process.env.SERVER_PORT;

app.listen(PORT, (error) => {
    if (error) {
        console.error(error);
    } else {
        console.log(`Server in ascolto sulla port ${PORT}`);
    }
});
