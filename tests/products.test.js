import { describe, it, expect } from 'vitest';

const baseUrl = "http://localhost:3000";

describe('API /products', () => {

    it("GET /products rispondo 200", async () => {
        const response = await request(baseUrl).get("/products");
        expect(response.status).toBe(200);
    });

    it("GET /products risponde con un array", async () => {
        const response = await request(baseUrl).get("/products");
        expect(Array.isArray(response.body)).toBe(true);
    });

    it("GET /products/:id con id esistente risponde 200 con il prodotto", async () => {
        const response = await request(baseUrl).get("/products/1");
        expect(response.status).toBe(200);
        expect(response.body).toHaveProperty("id", 1);
    });

    it("GET /products/:id con id intero ma inesistente risponde 404", async () => {
        const response = await request(baseUrl).get("/products/999999");
        expect(response.status).toBe(404);
    });

    it("GET /products/:id con id non numerico risponde 404", async () => {
        const response = await request(baseUrl).get("/products/abc");
        expect(response.status).toBe(404);
    });

    it("GET /products/rotta-inesistente risponde 404", async () => {
        const response = await request(baseUrl).get("/products/1/rotta-inesistente");
        expect(response.status).toBe(404);
    });
});
