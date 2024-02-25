import axios from 'axios';
import {
	GGMAP_GEOCODE_URL,
	OPEN_WEATHER_URL,
	GGMAP_AQI_URL,
} from '../config/const.js';
import { getLatAndLng } from '../utils/utils.js';
const getCurrentWeatherData = async (req, res) => {
	const { lat, lng } = req.query; 
	try {
		console.log(`lat: ${lat}, lng: ${lng}`);
		const weather = await axios.get(OPEN_WEATHER_URL, {
			headers: {
				'Content-Type': 'application/json',
			},
			params: {
				lat: lat,
				lon: lng,
				exclude: 'minutely,hourly,daily,alert',
				units: 'metric',
				appid: process.env.OPEN_WEATHER_API_KEY,
			},
		});
		const { current } = await weather.data;
		const aqiRequest = axios.post(
			GGMAP_AQI_URL,
			{
				universalAqi: false,
				location: {
					latitude: lat,
					longitude: lng,
				},
				extraComputations: ['HEALTH_RECOMMENDATIONS', 'LOCAL_AQI'],
			},
			{
				headers: { 'Content-Type': 'application/json' },
				params: { key: process.env.GGMAP_API_KEY },
			}
		);
		const { data } = await aqiRequest;
		const { aqi, category } = data.indexes[0];
		const healthRecommendations = data.healthRecommendations;
		return res.status(200).json({
			status: true,
			message: 'OK',
			data: {
				airQuality: {
					aqi,
					category,
					healthRecommendations,
				},
				weather: { ...current },
			},
		});
	} catch (error) {
		console.log('Error fetch weather data', error);
		return res.status(500).json({
			status: false,
			message: error.message,
			data: null,
		});
	}
};

const getForecastWeatherData = async (req, res) => {
	const { days, location } = req.query;
	const currentDate = new Date();
	//add 4 days to current date
	let forecastDate = new Date(currentDate);
	forecastDate.setDate(forecastDate.getDate() + parseInt(days));
	//convert to string

	forecastDate = forecastDate.toISOString().split('T')[0];
	console.log(forecastDate);
	try {
		const { lat, lng } = await getLatAndLng(location);
		console.log(`lat: ${lat}, lng: ${lng}`);
		const weather = await axios.get(`${OPEN_WEATHER_URL}/day_summary`, {
			headers: {
				'Content-Type': 'application/json',
			},
			params: {
				lat: lat,
				lon: lng,
				date: forecastDate,
				appid: process.env.OPEN_WEATHER_API_KEY,
				units: 'metric',
			},
		});
		const { humidity, wind, precipitation, temperature } = await weather.data;
		return res.status(200).json({
			status: true,
			message: 'OK',
			data: {
				forecastWeather: {
					humidity: humidity.afternoon,
					wind,
					precipitation: precipitation.total,
					temperature,
				},
			},
		});
	} catch (error) {
		console.log('Error fetch weather data', error);
		return res.status(500).json({
			status: false,
			message: error.message,
			data: null,
		});
	}
};

export { getCurrentWeatherData, getForecastWeatherData };
