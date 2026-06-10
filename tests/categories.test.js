import { describe, it, expect } from 'vitest';

const baseUrl = "http://localhost:3000";

describe('API /categories', () => {

    it("GET /categories rispondo 200", async () => {
        const response = await request(baseUrl).get("/categories");
        expect(response.status).toBe(200);
    });

    it("GET /categories risponde con un array", async () => {
        const response = await request(baseUrl).get("/categories");
        expect(Array.isArray(response.body)).toBe(true);
    });

    it("GET /categories/:id con id esistente risponde 200 con la categoria", async () => {
        const response = await request(baseUrl).get("/categories/1");
        expect(response.status).toBe(200);
        expect(response.body).toHaveProperty("id", 1);
    });

    it("GET /categories/:id con id intero ma inesistente risponde 404", async () => {
        const response = await request(baseUrl).get("/categories/999999");
        expect(response.status).toBe(404);
    });

    it("GET /categories/:id con id non numerico risponde 404", async () => {
        const response = await request(baseUrl).get("/categories/abc");
        expect(response.status).toBe(404);
    });

    it("GET /categories/rotta-inesistente risponde 404", async () => {
        const response = await request(baseUrl).get("/categories/1/rotta-inesistente");
        expect(response.status).toBe(404);
    });
});
