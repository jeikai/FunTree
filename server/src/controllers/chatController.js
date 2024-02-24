import chat from '@/config/gemini';
import ChatHistory from '@/model/ChatHistory';
import { gemini } from '@/config/gemini';
export const getChatResponse = async (req, res) => {
	const { prompt } = await req.body;
	const result = await chat.sendMessage(prompt);
	const response = await result.response;
	const text = response.text();
	const addChatHistory = await ChatHistory.addChatHistory(prompt, text).catch(
		(error) => {
			console.log(error);
		}
	);
	return res.status(200).json({
		status: true,
		message: 'OK',
		data: {
			response: text,
		},
	});
};
export const getChatHistory = async (req, res) => {
	const history = await ChatHistory.getAllHistory();
	return res.status(200).json({
		status: true,
		message: 'OK',
		data: {
			history: history,
		},
	});
};

export const deleteChatHistory = async (req, res) => {
	const deleteHistory = await ChatHistory.deleteAllHistory();
	return res.status(200).json({
		status: true,
		message: 'OK',
		data: {
			history: deleteHistory,
		},
	});
};
// export const createNewChat = async (req, res) => {
// 	const history = await ChatHistory.getAllHistory();
// 	chat = gemini.startChat({ history: history });

// 	const prevHis = await chat.getHistory();
// 	console.log('prevHis', prevHis);
// 	return res.status(200).json({
// 		status: true,
// 		message: 'OK',
// 		data: {
// 			history: prevHis,
// 		},
// 	});
// };
