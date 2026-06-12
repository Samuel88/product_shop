import { createAgent } from "langchain";
import model from "../models/openrouter.js";
import { getReviewsByProductId } from "../tools/product.tool.js";

const genericAgent = createAgent({
    model,
    tools: [
        getReviewsByProductId
    ]
});

export default genericAgent;