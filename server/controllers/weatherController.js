const axios = require('axios');
const { GGMAP_GEOCODE_URL, OPEN_WEATHER_URL } = require('../config/const');

/**
 * Retrieves weather data for a given location.
 * @param {string} location - The location for which to retrieve weather data.
 * @returns {Promise<string|null>} - A promise that resolves to a JSON string containing the weather data, or null if an error occurs.
 */
const getWeatherData = async (location) => {
	const geometry = await getLatAndLon(location);
	const { lat, lng } = JSON.parse(geometry);

	try {
		const weather = await axios.get(OPEN_WEATHER_URL, {
			method: 'GET',
			headers: {
				'Content-Type': 'application/json',
			},
			params: {
				lat: lat,
				lon: lng,
				appid: process.env.OPEN_WEATHER_API_KEY,
			},
		});
		const { timezone, current } = await weather.data;
		return JSON.stringify({
			timezone,
			...current,
		});
	} catch (error) {
		console.log('Error fetch weather data', error);
		return null;
	}
};

/**
 * Retrieves the latitude and longitude coordinates for a given location.
 * @param {string} location - The location for which to retrieve the coordinates.
 * @returns {Promise<string|null>} A promise that resolves to a JSON string containing the latitude and longitude coordinates, or null if an error occurs.
 */
const getLatAndLon = async (location) => {
	try {
		const geoInfo = await axios.get(GGMAP_GEOCODE_URL, {
			method: 'GET',
			params: {
				address: location,
				key: process.env.GGMAP_API_KEY,
			},
			headers: {
				'Content-Type': 'application/json',
			},
		});

		const body = geoInfo.data;

		const geometry = body.results[0].geometry;
		return JSON.stringify({
			lat: geometry.location.lat,
			lng: geometry.location.lng,
		});
	} catch (error) {
		console.log('Error fetching geometry info', error.data);
		return null;
	}
};
module.exports = {
	getWeatherData,
};
