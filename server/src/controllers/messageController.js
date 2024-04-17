import chat from '@/config/gemini';
import Message from '@/model/Message';
const axios = require('axios');

export const getChatResponse = async (req, res) => {
	const { prompt } = await req.body;
	const options = {
		method: 'POST',
		url: 'https://chat-gpt26.p.rapidapi.com/',
		headers: {
			'content-type': 'application/json',
			'Content-Type': 'application/json',
			'X-RapidAPI-Key': '15b6459fb0msh5a4b07bd1e48851p17b2a3jsn7cac2df65bab',
			'X-RapidAPI-Host': 'chat-gpt26.p.rapidapi.com'
		},
		data: {
			model: 'gpt-3.5-turbo',
			messages: [
				{
					role: 'user', 
					content: prompt
				}
			]
		}
	};
	const {data} = await axios.request(options);

	return res.status(200).json({
		status: true,
		message: 'OK',
		data: {
			response: data.choices[0].message.content,
		},
	});
};
export const getMessage = async (req, res) => {
	const history = await Message.getAllHistory();
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

