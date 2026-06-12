import { ChatOpenRouter } from "@langchain/openrouter";

const model = new ChatOpenRouter({
    model: "deepseek/deepseek-v4-flash"
});

export default model;