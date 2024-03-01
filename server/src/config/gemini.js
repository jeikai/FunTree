import { GoogleGenerativeAI } from '@google/generative-ai';
import dotenv from 'dotenv';
dotenv.config();
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
export const gemini = genAI.getGenerativeModel({ model: 'gemini-pro' });
let geminiChat = gemini.startChat({
    history: []
});
console.log('Init gemini success!');
export default geminiChat;
