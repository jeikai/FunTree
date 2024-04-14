import express, { Router } from 'express';
import {
	getCurrentWeatherData,
	getForecastWeatherData,
} from '../controllers/weatherController.js';
const api = Router();

api.get('/api/weather/current', getCurrentWeatherData);
api.get('/api/weather/forecast', getForecastWeatherData);
export default api;
 