import { Router } from 'express';
import { register, login, getUser } from '../controllers/userController';
const api = Router();

api.post('/api/user/login', login);
api.post('/api/user/register', register);
api.get('/api/user/:userId', getUser);
export default api;
 