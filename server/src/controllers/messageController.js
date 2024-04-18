import chat from '@/config/gemini';
import Message from '@/model/Message';
import dotenv from 'dotenv';
dotenv.config();
const axios = require('axios');
let apikey = process.env.GPT_API_KEY
console.log(apikey)
const systemMessage = {
	"role": "system", "content": "Bạn là một chuyên gia chăm sóc cây trồng"
};
let messages = [
	{
		message: "Bạn là một chuyên gia chăm sóc cây trồng",
		sender: "bot"
	}
];
export const getChatResponse = async (req, res) => {
	try {
		const { prompt } = await req.body;
		messages.push({
			message: prompt,
			sender: "user"
		});
		// apikey = apikey.replace(/^funtree-|(?<=.)(?=-funbug$)|-funbug$/g, '');
		let apiMessages = messages.map((messageObject) => {
			let role = "";
			if (messageObject.sender === "bot") {
				role = "assistant";
			} else {
				role = "user";
			}
			return { role: role, content: messageObject.message };
		});

		const apiRequestBody = {
			"model": "gpt-3.5-turbo",
			"messages": [
				{
					"role": "system",
					"content": systemMessage.content
				},
				...apiMessages
			]
		};

		const response = await axios.post("https://api.openai.com/v1/chat/completions", apiRequestBody, {
			headers: {
				"Authorization": `Bearer ${apikey}`,
				"Content-Type": "application/json"
			}
		});
		// const response = await Message.addChatHistory(prompt, data.choices[0].message.content)
		return res.status(200).json({
			status: true,
			message: 'OK',
			data: {
				response: response,
			},
		});
	} catch (error) {
		console.log(error)
	}
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

