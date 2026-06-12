import { ChatOpenAI } from "@langchain/openai";
import { createAgent, HumanMessage } from 'langchain'

const model = new ChatOpenAI({
    apiKey: "",
    configuration: {
        baseURL: "https://integrate.api.nvidia.com/v1",
    },
    model: "qwen/qwen3.5-122b-a10b",
});

export default model;