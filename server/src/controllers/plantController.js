import axios from 'axios';
import { PLANT_ID_URL } from '@/config/const';

import {
	GGMAP_GEOCODE_URL,
	OPEN_WEATHER_URL,
	GGMAP_AQI_URL,
} from '../config/const.js';
import Plant from '@/model/Plant.js';
import { getLatAndLng } from '../utils/utils.js';
export const identifyPlant = async (req, res) => {
	//! Plant image must be a base64 string
	const { images, location } = await req.body;
	const { lat, lng } = await getLatAndLng(location);

	try {
		const plantIdentification = await axios.post(
			`${PLANT_ID_URL}/identification`,
			{
				images: images,
				latitude: lat,
				longitude: lng,
			},
			{
				headers: {
					'Content-Type': 'application/json',
					'Api-Key': process.env.PLANT_ID_API_KEY,
				},
				params: {
					details:
						'common_names,url,description,image,edible_parts,watering,propagation_methods',
				},
			}
		);
		const { access_token, result } = await plantIdentification.data;
		const plantInfo = result.classification.suggestions[0];
		const healthAssessment = await axios.post(
			`${PLANT_ID_URL}/health_assessment`,
			{
				images: images,
				latitude: lat,
				longitude: lng,
			},
			{
				headers: {
					'Content-Type': 'application/json',
					'Api-Key': process.env.PLANT_ID_API_KEY,
				},
				params: {
					details:
						'local_name,description,url,treatment,classification,common_names,cause',
				},
			}
		);
		const healthResult = await healthAssessment.data;
		
		//* Save plants to database	
		const data = {
			plant_id: plantInfo.id,
			name: plantInfo.name,
			common_names: plantInfo.details.common_names[0],
			url: plantInfo.details.url,
			description: plantInfo.details.description != null ? plantInfo.details.description : 'No description available',
			edible_parts: plantInfo.details.edible_parts,
			watering: {
				max: plantInfo.details.watering.max,
				min: plantInfo.details.watering.min,
			},
		};
		const newPlant = await Plant.addNewPlant(data);
		
		return res.status(200).json({
			status: true,
			message: 'Plant identified successfully',
			data: {
				plantInfo: plantInfo,
				healthAssessment: healthResult.result,
			},
		});
	} catch (error) {
		return res.status(500).json({
			status: false,
			message: error.message,
		});
	}
};
