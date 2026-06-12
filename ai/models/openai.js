import { ChatOpenAI } from "@langchain/openai";
import { createAgent, HumanMessage } from 'langchain'

const model = new ChatOpenAI({
    apiKey: "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",
    configuration: {
        baseURL: "https://integrate.api.nvidia.com/v1",
    },
    model: "qwen/qwen3.5-122b-a10b",
});

export default model;