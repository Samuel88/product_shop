import { describe, it, expect } from 'vitest';

const baseUrl = "http://localhost:3000";

describe('API /reviews', () => {

    it("GET /reviews rispondo 200", async () => {
        const response = await request(baseUrl).get("/reviews");
        expect(response.status).toBe(200);
    });

    it("GET /reviews risponde con un array", async () => {
        const response = await request(baseUrl).get("/reviews");
        expect(Array.isArray(response.body)).toBe(true);
    });

    it("GET /reviews/:id con id esistente risponde 200 con la review", async () => {
        const response = await request(baseUrl).get("/reviews/1");
        expect(response.status).toBe(200);
        expect(response.body).toHaveProperty("id", 1);
    });

    it("GET /reviews/:id con id intero ma inesistente risponde 404", async () => {
        const response = await request(baseUrl).get("/reviews/999999");
        expect(response.status).toBe(404);
    });

    it("GET /reviews/:id con id non numerico risponde 404", async () => {
        const response = await request(baseUrl).get("/reviews/abc");
        expect(response.status).toBe(404);
    });

    it("GET /reviews/rotta-inesistente risponde 404", async () => {
        const response = await request(baseUrl).get("/reviews/1/rotta-inesistente");
        expect(response.status).toBe(404);
    });

    it("POST /reviews con dati validi risponde 201 e crea la review", async () => {
        const response = await request(baseUrl)
            .post("/reviews")
            .send({
                product_id: 1,
                name: "Test User",
                rating: 5,
                title: "Ottimo",
                content: "Recensione di test creata automaticamente."
            });

        expect(response.status).toBe(201);
        expect(response.body).toHaveProperty("id");
    });

    it("POST /reviews con dati mancanti risponde 400", async () => {
        const response = await request(baseUrl)
            .post("/reviews")
            .send({ name: "Test User" });

        expect(response.status).toBe(400);
    });

    it("PATCH /reviews/:id con id esistente risponde 200 e aggiorna la review", async () => {
        const response = await request(baseUrl)
            .patch("/reviews/1")
            .send({ title: "Titolo aggiornato" });

        expect(response.status).toBe(200);
        expect(response.body).toHaveProperty("title", "Titolo aggiornato");
    });

    it("PATCH /reviews/:id con id inesistente risponde 404", async () => {
        const response = await request(baseUrl)
            .patch("/reviews/999999")
            .send({ title: "Titolo aggiornato" });

        expect(response.status).toBe(404);
    });

    it("PATCH /reviews/:id con id non numerico risponde 404", async () => {
        const response = await request(baseUrl)
            .patch("/reviews/abc")
            .send({ title: "Titolo aggiornato" });

        expect(response.status).toBe(404);
    });

    it("DELETE /reviews/:id con id esistente risponde 200", async () => {
        const created = await request(baseUrl)
            .post("/reviews")
            .send({
                product_id: 1,
                name: "Da Eliminare",
                rating: 3,
                title: "Da cancellare",
                content: "Recensione di test da eliminare."
            });

        const response = await request(baseUrl).delete(`/reviews/${created.body.id}`);
        expect(response.status).toBe(200);
    });

    it("DELETE /reviews/:id con id inesistente risponde 404", async () => {
        const response = await request(baseUrl).delete("/reviews/999999");
        expect(response.status).toBe(404);
    });

    it("DELETE /reviews/:id con id non numerico risponde 404", async () => {
        const response = await request(baseUrl).delete("/reviews/abc");
        expect(response.status).toBe(404);
    });
});
