import { z } from "zod";
import { tool } from "langchain";

function getRandomInt(min, max) {
    console.log('Chiamata a getRandomInt');
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

const toolDefinition = {
    name: "randomInt",
    description: "Genera un numero intero casuale tra min e max",
    schema: z.object({
        min: z.int().default(0).describe("Il numero minimo (inclusivo)"),
        max: z.int().default(100).describe("Il numero massimo (inclusivo)")
    })
};

const randomIntTool = tool(getRandomInt, toolDefinition);

export {
    randomIntTool
}