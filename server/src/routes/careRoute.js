import { Router } from 'express';
import {
	getWateringData,
	getFertilizingData,
} from '@/controllers/careController.js';

const api = Router();
api.get('/api/care/watering', getWateringData);
api.get('/api/care/fertilizing', getFertilizingData);
export default api;
