const express = require('express')
const api = express.Router();
const weatherController = require('../controllers/weatherController')

api.get("/api/weather", weatherController.getCurrentWeatherData)

module.exports = api;


