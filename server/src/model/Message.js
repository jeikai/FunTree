import mongoose from 'mongoose';
import User from '@/model/User'
const messageSchema = new mongoose.Schema({
	message: { type: String, required: true, default: '' },
	sender: { type: String, required: true, default: 'user' },
});
const Message = mongoose.model('Message', messageSchema);

const addChatHistory = async (userId, userMessage, modelMessage) => {
	try {
	  const user = await User.get(userId);
  
	  if (!user) {
		throw new Error('User not found');
	  }
  
	  const userChat = new Message({
		message: userMessage,
		sender: 'user',
	  });
	  const modelChat = new Message({
		message: modelMessage,
		sender: 'bot',
	  });

	  await userChat.save();
	  await modelChat.save();
 
	  user.listMessage = user.listMessage || []
	  user.listMessage.push(userChat._id, modelChat._id);
	  await User.update(userId, user)
  
	  return { userChat, modelChat };
	} catch (error) {
	  console.error('Error adding chat history:', error);
	  throw error; 
	} 
  };

const getAllHistory = async (userId) => {
	const user = await User.get(userId);
	console.log(user)
	if (!user) {
	  throw new Error('User not found');
	}

	return user.listMessage; 
};

const deleteAllHistory = async () => {
	const deleteHistory = await ChatHistory.deleteMany();
	return deleteHistory;
};
export default { addChatHistory, getAllHistory, deleteAllHistory };
