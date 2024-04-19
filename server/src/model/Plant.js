const mongoose = require('mongoose')
const Schema = mongoose.Schema

const plantSchema = new Schema({
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
	listHistory: [{ type: mongoose.Schema.Types.ObjectId, ref: 'History', default: '' }],
	position: { type: String, default: '' },
	forecastId: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Forecast', default: '' }]
});

const Plant = mongoose.model('Plant', plantSchema);
exports.schema = Plant

const addNewPlant = async (plantData) => {
	try {
		const data = {
			name: plantData.name,
			common_names: plantData.common_names,
			url: plantData.url,
			description: plantData.description
		}
		const newPlant = Plant(data);

		await newPlant.save();
		return newPlant;
	} catch (err) {
		console.log(err)
		return;
	}
};
const deletePlant = async () => {
	try {
		const deletedPlants = await Plant.deleteMany({}); // Delete all documents
		return deletedPlants.deletedCount; // Return the number of deleted documents
	} catch (err) {
		console.error(err);
		return null; // Or throw an error if you prefer
	}
};
const getPlant = async (plantId) => {
	const plant = await Plant.findById(plantId).populate("listHistory", "forecastId");
	return plant;
};

const getAll = async function () {
    try {
        const users = await Plant.find({});
        return users;
    } catch (e) {
		console.log(e)
        return { error: e };
    }
};
export default {
	addNewPlant,
	deletePlant,
	getPlant,
	getAll
};
