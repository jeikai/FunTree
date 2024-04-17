import express, { Router } from 'express';
import {
	getChatResponse,
	getMessage,
	deleteMessage,
	// createNewChat,
} from '@/controllers/messageController';
const api = Router();
// api.get('/api/gemini/create-chat', createNewChat);
api.post('/api/chat', getChatResponse);
api.get('/api/gemini/history', getMessage);
api.delete('/api/gemini/history', deleteMessage);
export default api;
