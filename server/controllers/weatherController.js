const axios = require('axios');
const {
	GGMAP_GEOCODE_URL,
	OPEN_WEATHER_URL,
	GGMAP_AQI_URL,
} = require('../config/const');

/**
 * Retrieves the Air Quality Index (AQI) information for a given latitude and longitude.
 * @param {number} lat - The latitude of the location.
 * @param {number} lng - The longitude of the location.
 * @returns {Promise<number|null>} The AQI value or null if an error occurs.
 */
const getAQIInfo = async (lat, lng) => {
	try {
		const aqiRequest = axios.post(
			GGMAP_AQI_URL,
			{
				location: {
					latitude: lat,
					longitude: lng,
				},
			},
			{
				headers: {
					'Content-Type': 'application/json',
				},
				params: {
					key: process.env.GGMAP_API_KEY,
				},
			}
		);
		const { data } = await aqiRequest;
		const aqi = data.indexes[0].aqi;
		return aqi;
	} catch (error) {
		console.log('Error fetch AQI data', error);
		return null;
	}
};

/**
 * Retrieves the latitude and longitude for a given location.
 * @param {string} location - The location.
 * @returns {Promise<{lat: number, lng: number}|null>} The latitude and longitude of the location or null if an error occurs.
 */
const getLatAndLng = async (location) => {
	try {
		const geoInfo = await axios.get(GGMAP_GEOCODE_URL, {
			params: {
				address: location,
				key: process.env.GGMAP_API_KEY,
			},
			headers: {
				'Content-Type': 'application/json',
			},
		});
		const { lat, lng } = geoInfo.data.results[0].geometry.location;
		return { lat, lng };
	} catch (error) {
		console.log('Error fetch lat and lng', error);
		return null;
	}
};

/**
 * Retrieves weather data for a given latitude and longitude.
 * @param {number} lat - The latitude.
 * @param {number} lng - The longitude.
 * @returns {Promise<{timezone: string, current: object}>} The weather data, including the timezone and current weather information.
 */
const getWeather = async (lat, lng) => {
	try {
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
		const { timezone, current } = await weather.data;
		return { timezone, current };
	} catch (error) {
		console.log('Error fetch weather data', error);
		return null;
	}
};

/**
 * Retrieves weather data for a given location.
 * @param {Object} req - The request object.
 * @param {Object} res - The response object.
 * @returns {Object} The weather data for the location.
 */
exports.getCurrentWeatherData = async (req, res) => {
	const { location } = req.query;
	try {
		const { lat, lng } = await getLatAndLng(location);
		const { timezone, current } = await getWeather(lat, lng);
		const aqiIndex = await getAQIInfo(lat, lng);
		return res.status(200).json({
			status: true,
			message: 'OK',
			data: { aqiIndex, timezone, ...current },
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
