import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import routers from './routes/index.js';
import connectDB from './config/mongodb.js';
import multer from 'multer';

dotenv.config();
connectDB();
const app = express();
const PORT = process.env.PORT || 5000;
app.use(
	express.json({
		limit: '20mb',
	})
);
app.use(cors());
app.use(
	express.urlencoded({
		extended: true,
	})
);

app.use(routers);
const server = app.listen(PORT, () => {
	console.log(`Server running at http://localhost:${PORT}`);
});
