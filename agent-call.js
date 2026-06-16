import { createAgent, HumanMessage } from 'langchain'
import model from './ai/models/anthropic.js';
import { randomIntTool } from './ai/tools/random.tool.js';

const tools = [
    randomIntTool
];

const agent = createAgent({
    model,
    tools
});

const response = await agent.invoke({
    messages: [
        new HumanMessage('Mi dai un numero casuale tra 1 e 100?')
    ]
});
console.log(response.messages.at(-1).content);