import { Router } from 'express';
import { identifyPlant } from '@/controllers/plantController';
const api = Router();

api.post('/api/plant/identification', identifyPlant);

export default api;
