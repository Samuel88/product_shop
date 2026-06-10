import request from 'supertest';
import { describe, it, expect } from 'vitest';

const baseUrl = "http://localhost:3000";

describe('API /products', () => {

    it("GET /products rispondo 200", async () => {
        const response = await request(baseUrl).get("/products");
        expect(response.status).toBe(200);
    });
});