import chat from '@/config/gemini';
import Message from '@/model/Message';
import dotenv from 'dotenv';
dotenv.config();
const axios = require('axios');

export const getChatResponse = async (req, res) => {
	try {
		const userId = req.params.userId; 
		console.log(userId)
		const { prompt } = await req.body;
		const result = await chat.sendMessage(prompt);
		const response = await result.response;
		const text = response.text();
		const response_save = await Message.addChatHistory(userId, prompt, text)
		return res.status(200).json({
			status: true,
			message: 'OK',
			data: {
				response: response_save,
			},
		});
	} catch (error) {
		return res.status(500).json({ message: error })
	}
};
export const getMessage = async (req, res) => {
	const userId = req.params.userId;
	const history = await Message.getAllHistory(userId);
	return res.status(200).json({
		status: true,
		message: 'OK',
		data: { 
			history: history,
		},
	});
};

export const deleteMessage = async (req, res) => {
	const deleteHistory = await Message.deleteAllHistory();
	return res.status(200).json({
		status: true,
		message: 'OK',
		data: {
			history: deleteHistory,
		},
	});
};

