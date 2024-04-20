import express, { Router } from 'express';
import {
	getChatResponse,
	getMessage,
	deleteMessage,
	// createNewChat,
} from '@/controllers/messageController';
const api = Router();
// api.get('/api/gemini/create-chat', createNewChat);
api.post('/api/chat/:userId', getChatResponse);
api.get('/api/chat/:userId', getMessage);
api.delete('/api/gemini/history', deleteMessage);
export default api;
