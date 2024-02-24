import axios from 'axios';
import { PLANT_ID_URL } from '@/config/const';

export const identifyPlant = async (req, res) => {
	//! Plant image must be a base64 string

	const { images } = await req.body;
	try {
		const response = await axios.post(
			`${PLANT_ID_URL}/identification`,
			{
				images: images,
			},
			{
				headers: {
					'Content-Type': 'application/json',
					'Api-Key': process.env.PLANT_ID_API_KEY,
				},
			}
		);
		const { result } = await response.data;
		// const isPlant = result.classification.is_plant.binary;
		// if (isPlant) {
			const plantName = result.classification.suggestions[0].name;
        console.log(plantName);
			return res.status(200).json({
				status: true,
				message: 'Plant identified successfully',
				data: plantName,
			});
		// }
		// return res.status(400).json({
		// 	status: true,
		// 	message: 'Not a plant',
		// 	data: null,
		// });
	} catch (error) {
		return res.status(500).json({
			status: false,
			message: error.message,
		});
	}
};
