import { ChatAnthropic } from "@langchain/anthropic";

const model = new ChatAnthropic({
    apiKey: process.env.ANTHROPIC_API_KEY,
    model: "claude-haiku-4-5",
    temperature: 0.7,
});

export default model;