import { describe, it, expect } from 'vitest';

const baseUrl = "http://localhost:3000";

describe('API /categories', () => {

    it("GET /categories rispondo 200", async () => {
        const response = await fetch(`${baseUrl}/categories`);
        expect(response.status).toBe(200);
    });

    it("GET /categories risponde con un array", async () => {
        const response = await fetch(`${baseUrl}/categories`);
        const body = await response.json();
        expect(Array.isArray(body)).toBe(true);
    });

    it("GET /categories/:id con id esistente risponde 200 con la categoria", async () => {
        const response = await fetch(`${baseUrl}/categories/1`);
        const body = await response.json();
        expect(response.status).toBe(200);
        expect(body).toHaveProperty("id", 1);
    });

    it("GET /categories/:id con id intero ma inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/categories/999999`);
        expect(response.status).toBe(404);
    });

    it("GET /categories/:id con id non numerico risponde 404", async () => {
        const response = await fetch(`${baseUrl}/categories/abc`);
        expect(response.status).toBe(404);
    });

    it("GET /categories/rotta-inesistente risponde 404", async () => {
        const response = await fetch(`${baseUrl}/categories/1/rotta-inesistente`);
        expect(response.status).toBe(404);
    });
});
