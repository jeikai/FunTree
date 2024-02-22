const axios = require('axios');
const { GGMAP_GEOCODE_URL } = require('../config/const');

//! Need current location from FE
const getWeatherData = async (loc) => {
	// getLatandLon
	const geometry = await getLatandLon(loc);
	const { lat, lng } = JSON.parse(geometry);
	const appid = process.env.OPEN_WEATHER_API_KEY;

	try {
		const weather = await axios.get(
			'https://api.openweathermap.org/data/3.0/onecall',
			{
				method: 'GET',
				headers: {
					'Content-Type': 'application/json',
				},
				params: {
					lat: lat,
					lon: lng,
					appid: appid,
				},
			}
		);
		const { timezone, current } = await weather.data;
		return JSON.stringify({
			timezone,
			...current,
		});
	} catch (error) {
		console.log('Error fetch weather data', error);
	}
	return null;
};
const getLatandLon = async (loc) => {
	try {
		const geoInfo = await axios.get(GGMAP_GEOCODE_URL, {
			method: 'GET',
			params: {
				address: loc,
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
	}
};
module.exports = {
	getWeatherData,
};

getWeatherData('Hanoi, Vietnam');
