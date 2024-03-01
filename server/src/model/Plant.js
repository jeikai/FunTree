import { url } from 'inspector';
import mongoose, { Schema } from 'mongoose';

const plantSchema = new Schema({
	plant_id: {
		type: String,
		required: true,
	},
	name: {
		type: String,
		required: true,
	},
	common_names: {
		type: String,
		required: true,
	},
	url: {
		type: String,
		required: true,
	},
	description: {
		type: String,
		required: true,
	},

	edible_parts: {
		type: [String],
		required: false,
	},
	watering: {
		min: Number,
		max: Number,
	},
	
});

const Plant = new mongoose.model('Plant', plantSchema);

const addNewPlant = async (plantData) => {
	const newPlant = new Plant(plantData);
	await newPlant.save();
	return newPlant;
};
const deletePlant = async (plantId) => {
	const plant = await Plant.findByIdAndDelete(plantId);
	return plant;
};
const getPlant = async (plantId) => {
	const plant = await Plant.findById(plantId);
	return plant;
};
export default {
	addNewPlant,
	deletePlant,
	getPlant,
};
