import { describe, it, expect } from 'vitest';

const baseUrl = "http://localhost:3000";

describe('API /reviews', () => {

    it("GET /reviews rispondo 200", async () => {
        const response = await fetch(`${baseUrl}/reviews`);
        expect(response.status).toBe(200);
    });

    it("GET /reviews risponde con un array", async () => {
        const response = await fetch(`${baseUrl}/reviews`);
        const body = await response.json();
        expect(Array.isArray(body)).toBe(true);
    });

    it("GET /reviews/:id con id esistente risponde 200 con la review", async () => {
        const response = await fetch(`${baseUrl}/reviews/1`);
        const body = await response.json();
        expect(response.status).toBe(200);
        expect(body).toHaveProperty("id", 1);
    });

    it("GET /reviews/:id con id intero ma inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/reviews/999999`);
        expect(response.status).toBe(404);
    });

    it("GET /reviews/:id con id non numerico risponde 404", async () => {
        const response = await fetch(`${baseUrl}/reviews/abc`);
        expect(response.status).toBe(404);
    });

    it("GET /reviews/rotta-inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/reviews/1/rotta-inesistente`);
        expect(response.status).toBe(404);
    });

    it("POST /reviews con dati validi risponde 201 e crea la review", async () => {
        const response = await fetch(`${baseUrl}/reviews`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                product_id: 1,
                name: "Test User",
                rating: 5,
                title: "Ottimo",
                content: "Recensione di test creata automaticamente."
            })
        });
        const body = await response.json();

        expect(response.status).toBe(201);
        expect(body).toHaveProperty("id");
    });

    it("POST /reviews con dati mancanti risponde 400", async () => {
        const response = await fetch(`${baseUrl}/reviews`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ name: "Test User" })
        });

        expect(response.status).toBe(400);
    });

    it("PATCH /reviews/:id con id esistente risponde 200 e aggiorna la review", async () => {
        const response = await fetch(`${baseUrl}/reviews/1`, {
            method: "PATCH",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ title: "Titolo aggiornato" })
        });
        const body = await response.json();

        expect(response.status).toBe(200);
        expect(body).toHaveProperty("title", "Titolo aggiornato");
    });

    it("PATCH /reviews/:id con id inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/reviews/999999`, {
            method: "PATCH",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ title: "Titolo aggiornato" })
        });

        expect(response.status).toBe(404);
    });

    it("PATCH /reviews/:id con id non numerico risponde 404", async () => {
        const response = await fetch(`${baseUrl}/reviews/abc`, {
            method: "PATCH",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ title: "Titolo aggiornato" })
        });

        expect(response.status).toBe(404);
    });

    it("DELETE /reviews/:id con id esistente risponde 200", async () => {
        const created = await fetch(`${baseUrl}/reviews`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                product_id: 1,
                name: "Da Eliminare",
                rating: 3,
                title: "Da cancellare",
                content: "Recensione di test da eliminare."
            })
        });
        const createdBody = await created.json();

        const response = await fetch(`${baseUrl}/reviews/${createdBody.id}`, {
            method: "DELETE"
        });
        expect(response.status).toBe(200);
    });

    it("DELETE /reviews/:id con id inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/reviews/999999`, {
            method: "DELETE"
        });
        expect(response.status).toBe(404);
    });

    it("DELETE /reviews/:id con id non numerico risponde 404", async () => {
        const response = await fetch(`${baseUrl}/reviews/abc`, {
            method: "DELETE"
        });
        expect(response.status).toBe(404);
    });
});
