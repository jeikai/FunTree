import axios from 'axios';
import { PLANT_ID_URL } from '@/config/const';
import storage from '@/config/googleStorage.js';
import { GoogleGenerativeAI } from '@google/generative-ai';
import fs from 'fs';
import { joinNameWithMimeType, normalizeString } from '../utils/utils.js';
import Plant from '@/model/Plant.js';
import sharp from 'sharp';

export const identifyPlant = async (req, res) => {
	try {
		let { images, lat, lng } = req.body;
		lat = parseFloat(lat);
		lng = parseFloat(lng);

		const imageData = Buffer.from(images); 
		const base64Image = imageData.toString('base64');

		const plantIdentification = await axios.post(
			`${PLANT_ID_URL}/identification`,
			{
				images: base64Image,
				latitude: lat,
				longitude: lng,
			},
			{
				headers: {
					'Content-Type': 'application/json',
					'Api-Key': 'mLtpAB43sQtLog4jdQwziQsgoGxl9sGEsS6xTEJD4WBAXoJOxx',
				},
				params: {
					details:
						'common_names,url,description,image,edible_parts,watering,propagation_methods',
				},
			}
		);

		const { access_token, result, input } = plantIdentification.data;
		const isPlant = result.is_plant.binary;

		if (isPlant) {
			const plantInfo = result.classification.suggestions[0];

			const healthAssessment = await axios.post(
				`${PLANT_ID_URL}/health_assessment`,
				{
					images: base64Image,
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

			const healthResult = healthAssessment.data;

			const data = {
				plant_id: plantInfo.id,
				name: plantInfo.name,
				common_names: normalizeString(plantInfo.details.common_names[0]),
				url: plantInfo.details.url,
				description:
					plantInfo.details.description != null
						? plantInfo.details.description.value
						: 'No description available',
				edible_parts: plantInfo.details.edible_parts,
				watering: {
					max: plantInfo.details.watering.max,
					min: plantInfo.details.watering.min,
				},
				image: `${input.images[0]}`,
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
		} else {
			return res.status(400).json({
				status: false,
				message: "Not a plant"
			})
			// const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
			// const model = genAI.getGenerativeModel({ model: 'gemini-pro-vision' });

			// const prompt =
			// 	'How can i recycle this? Please give clear instruction or guideline on how to recycle this item or how can i convert this to plants fertilizer.';
			// const fileToGenerativePart = (buffer, mimeType) => {
			// 	return {
			// 		inlineData: {
			// 			data: buffer,
			// 			mimeType,
			// 		},
			// 	};
			// };
			// const imageParts = [fileToGenerativePart(base64Image, image.mimetype)];

			// const result = await model.generateContent([prompt, ...imageParts]);
			// const response = await result.response;
			// const text = response.text();

			// return res.status(200).json({
			// 	status: true,
			// 	message: 'identified successfully',
			// 	data: { response: text },
			// });
		}
	} catch (error) {
		console.log(error)
		return res.status(500).json({
			status: false,
			message: error,
		});
	}
};
