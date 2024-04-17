import axios from 'axios';
import {
	OPEN_WEATHER_URL,
	GGMAP_AQI_URL,
} from '../config/const.js';
import { getLatAndLng } from '../utils/utils.js';
const getCurrentWeatherData = async (req, res) => {
	const { lat, lng } = req.query;
	try {
		const weather = await axios.get(`${OPEN_WEATHER_URL}/current.json?key=${process.env.WEATHER_API_KEY}&q=${lat},${lng}`);
		const { current } = await weather.data;
		const aqiRequest = axios.get(
			GGMAP_AQI_URL,
			{
				params: {
					q: 'hanoi',
					'x-user-lang': 'en-US',
					'x-user-timezone': 'Asia/Hanoi',
					'x-units-pressure': 'mbar',
					'x-units-distance': 'kilometer',
					'x-units-temperature': 'celsius'
				},
				headers: {
					'X-RapidAPI-Key': '15b6459fb0msh5a4b07bd1e48851p17b2a3jsn7cac2df65bab',
					'X-RapidAPI-Host': 'airvisual1.p.rapidapi.com'
				}
			}

		);
		const { data } = await aqiRequest;
		const news = data.data.news
		const aqi = data.data.stations[0].currentMeasurement.aqius
		return res.status(200).json({
			status: true,
			message: 'OK',
			data: {
				airQuality: {
					aqi,
					news,
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
