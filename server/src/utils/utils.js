import axios from 'axios';
import { GGMAP_GEOCODE_URL } from '@/config/const';
import storage from '@/config/googleStorage';
import fs from 'fs';
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
export const uploadFileFromUrl = async (
	bucketName,
	imageBuffer,
	imageUrl,
	destinationFilename
) => {
	try {
		// Download the image from the URL
		const response = await axios.get(imageUrl, { responseType: 'stream' });

		// Create a temporary file to store the downloaded image
		const tempFilePath = path.join('/upload/temp_image.jpg');
		const writer = fs.createWriteStream(tempFilePath);

		// Pipe the image stream to the temporary file
		response.data.pipe(writer);

		// Wait for the image to finish downloading
		await new Promise((resolve, reject) => {
			writer.on('finish', resolve);
			writer.on('error', reject);
		});
		console.log('Downloaded image to', tempFilePath);
		// Upload the temporary file to Google Cloud Storage
		await storage().bucket(bucketName).upload(tempFilePath, {
			destination: destinationFilename,
			
		});

		console.log(
			`Image uploaded from ${imageUrl} to ${bucketName}/${destinationFilename}.`
		);

		// Delete the temporary file
		fs.unlinkSync(tempFilePath);
	} catch (error) {
		console.error('Error:', error);
	}
};
export const joinNameWithMimeType = (name, mimeType) => {
	return `${name}.${mimeType.split('/')[1]}`;
};
