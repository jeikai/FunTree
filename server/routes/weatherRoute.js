const express = require('express')
const api = express.Router();
const weatherController = require('../controllers/weatherController')

api.get("/api/weather/current", weatherController.getCurrentWeatherData)
api.get("/api/weather/forecast", weatherController.getForecastWeatherData)
module.exports = api;


