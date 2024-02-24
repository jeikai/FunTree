import mongoose from 'mongoose';

const chatHistorySchema = new mongoose.Schema({
	role: {
		type: String,
		required: true,
	},
	parts: [
		{
			text: String,
		},
	],
	timeStamp: {
		type: Date,
		default: Date.now,
	},
});
const ChatHistory = mongoose.model('ChatHistory', chatHistorySchema);

const addChatHistory = async (user, model) => {
	const userChat = new ChatHistory({
		role: 'user',
		parts: [
			{
				text: user,
			},
		],
	});
	await userChat.save();
	const modelChat = new ChatHistory({
		role: 'model',
		parts: [
			{
				text: model,
			},
		],
	});
	await modelChat.save();
	return { userChat, modelChat };
};

const getAllHistory = async () => {
	const documents = await ChatHistory.find({}).select({ _id: 0 }); 
	const history = documents.map((document) => ({
		role: document.role,
		parts: document.parts.map((part) => ({ text: part.text })),
	}));

	return history;
};

const deleteAllHistory = async () => {
	const deleteHistory = await ChatHistory.deleteMany();
	return deleteHistory;
};
export default { addChatHistory, getAllHistory, deleteAllHistory };
