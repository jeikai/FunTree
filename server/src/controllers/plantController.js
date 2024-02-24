import axios from 'axios';
import { PLANT_ID_URL } from '@/config/const';

export const identifyPlant = async (req, res) => {
	//! Plant image must be a base64 string
    
    const { plantImage } = req.body;
	try {
		const response = await axios.post(
			`${PLANT_ID_URL}/identification`,
			{
				images: [plantImage],
			},
			{
				headers: {
					'Content-Type': 'application/json',
					'Api-Key': process.env.PLANT_ID_API_KEY,
				},
			}
		);
		const { access_token, result } = await response.data;
		const isPlant = result.classification.is_plant.binary;
		if (isPlant) {
			const plantName = result.classification.suggestions[0].name;
			return res.status(200).json({
				status: true,
				message: 'Plant identified successfully',
				data: result,
			});
		}
		return res.status(400).json({
			status: true,
			message: 'Not a plant',
			data: null,
		});
	} catch (error) {
		return res.status(500).json({
			status: false,
			message: error.message,
		});
	}
};
