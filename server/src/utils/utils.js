import axios from 'axios';
import { GGMAP_GEOCODE_URL } from '@/config/const';
/**
 * Retrieves the latitude and longitude of a given location.
 * @param {string} location - The address or location to retrieve the coordinates for.
 * @returns {Promise<{ lat: number, lng: number } | null>} The latitude and longitude of the location, or null if an error occurred.
 */
export const getLatAndLng = async (location) => {
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
		// return { lat: 21.001743367574402, lng: 105.73834896399575 };
	} catch (error) {
		console.log('Error fetch lat and lng', error);
		return null;
	}
};

export const normalizeString = (string) => {
	return string
		.split(' ')
		.map((word) => word.charAt(0).toUpperCase() + word.slice(1))
		.join(' ');
};
