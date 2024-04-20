import { Router } from 'express';
import { identifyPlant, createPlant, deleteAllPlant, getAllPlant } from '@/controllers/plantController';
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
api.post('/api/plant/create', use(createPlant))
api.get('/api/plant', use(getAllPlant))
api.delete('/api/plant', use(deleteAllPlant))
export default api;
