import axios from 'axios';
import { PLANT_ID_URL } from '@/config/const';
import { joinNameWithMimeType, normalizeString } from '../utils/utils.js';
import Plant from '@/model/Plant.js';
import sharp from 'sharp';
require('dotenv').config()

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
					'Api-Key': process.env.PLANT_ID_API_KEY,
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

			return res.status(200).json({
				status: true,
				message: 'Plant identified successfully',
				data: {
					plantInfo: plantInfo,
					healthAssessment: healthResult.result,
					imageBase64: base64Image
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

export const createPlant = async (req, res) => {
	try {
		const data = req.body;
		const response = await Plant.addNewPlant(data)
		if( !response) {
			return res.status(400).json({
				status: false,
				message: "Created unsuccessfully",
			});
		}
		return res.status(200).json({
			status: true,
			message: 'Plant created successfully',
			data: {
				response: response
			},
		});
	} catch (error) {
		console.log(error)
		return res.status(500).json({
			status: false,
			message: error,
		});
	}
}

export const deleteAllPlant = async (req, res) => {
	try {
		const response = await Plant.deletePlant()
		return res.status(200).json({
			status: true,
			response: response
		})
	} catch (error) {
		return res.status(500).json({
			status: false,
			message: error,
		});
	}
}

export const getAllPlant = async (req, res) => {
	try {
		const response = await Plant.getAll();
		return res.status(200).json({
			status: true,
			response: response
		})
	} catch (error) {
		console.log(error)
		return res.status(500).json({
			status: false,
			message: error,
		});
	}
}