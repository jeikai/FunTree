import express, { Router } from 'express';
import {
	getChatResponse,
	getChatHistory,
	deleteChatHistory,
	// createNewChat,
} from '@/controllers/chatController'; 
const api = Router();
// api.get('/api/gemini/create-chat', createNewChat);
api.post('/api/gemini/chat', getChatResponse);
api.get('/api/gemini/history', getChatHistory);
api.delete('/api/gemini/history', deleteChatHistory);
export default api;
