import { Router } from 'express';
import { identifyPlant } from '@/controllers/plantController';
import multer from 'multer';
import { use } from '@/helper/utils';
const storage = multer.diskStorage({
	destination: (req, file, callback) => {
		callback(null, './uploads');
	},
	filename: (req, file, callback) => {
		callback(null, file.originalname);
	},
});
const upload = multer({ storage });

const api = Router();

api.post(
	'/api/plant/identification',
	upload.array('images'),
	use(identifyPlant)
);

export default api;
