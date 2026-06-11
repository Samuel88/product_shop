import { describe, it, expect } from 'vitest';

const baseUrl = "http://localhost:3000";

describe('API /products', () => {

    it("GET /products rispondo 200", async () => {
        const response = await fetch(`${baseUrl}/products`);
        expect(response.status).toBe(200);
    });

    it("GET /products risponde con un array", async () => {
        const response = await fetch(`${baseUrl}/products`);
        const body = await response.json();
        expect(Array.isArray(body)).toBe(true);
    });

    it("GET /products/:id con id esistente risponde 200 con il prodotto", async () => {
        const response = await fetch(`${baseUrl}/products/1`);
        const body = await response.json();
        expect(response.status).toBe(200);
        expect(body).toHaveProperty("id", 1);
    });

    it("GET /products/:id con id intero ma inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/products/999999`);
        expect(response.status).toBe(404);
    });

    it("GET /products/:id con id non numerico risponde 404", async () => {
        const response = await fetch(`${baseUrl}/products/abc`);
        expect(response.status).toBe(404);
    });

    it("GET /products/rotta-inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/products/1/rotta-inesistente`);
        expect(response.status).toBe(404);
    });

    // Test DELETE

    it("DELETE /products/:id con id esistente risponde 200", async () => {
        // Assume product with id 2 exists from seed data.
        const response = await fetch(`${baseUrl}/products/2`, {
            method: "DELETE"
        });
        expect(response.status).toBe(200);
    });

    it("DELETE /products/:id con id inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/products/999999`, {
            method: "DELETE"
        });
        expect(response.status).toBe(404);
    });

    it("DELETE /products/:id con id non numerico risponde 404", async () => {
        const response = await fetch(`${baseUrl}/products/abc`, {
            method: "DELETE"
        });
        expect(response.status).toBe(404);
    });
});
