import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();
const connectDB = async () => {
	try {
		const dbConfig = process.env.MONGO_URL;
		const connect = await mongoose.connect(dbConfig, {
			dbName: 'chat-app',
		});
		console.log(`Mongodb connected: ${connect.connection.host}`);
	} catch (e) {
		console.log('Error connect to mongodb');
	} 
};

export default connectDB;

  