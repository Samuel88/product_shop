import model from "../ai/models/openai.js";
import { HumanMessage } from "langchain";

async function chat(request, response) {
    const { prompt } = request.body;

    // Validazione minima
    if (!prompt || typeof prompt !== "string" || prompt.trim() === "") {
        response.status(400).json({
            error: "Il campo prompt è obbligatorio e deve essere una stringa non vuota",
            results: null
        });
        return;
    }

    const aiResponse = await model.invoke([
        new HumanMessage(prompt)
    ]);

    response.json({
        error: null,
        results: aiResponse.content
    });
}

export {
    chat
}