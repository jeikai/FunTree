const mongoose = require('mongoose')
const Schema = mongoose.Schema

const HistorySchema = new Schema({
	waterAmount: {
		type: Number,
		required: true,
        default: 0
	},
    fertilizerAmount: {
		type: Number,
		required: true,
        default: 0
	},
	dateCare: Date
});

const History = mongoose.model('History', HistorySchema, 'histories');
exports.schema = History

const addNewHistory = async (plantData) => {
    const data = {
        waterAmount: plantData.waterAmount,
        fertilizerAmount: plantData.fertilizerAmount,
        dateCare: new Date()
    }
	const newPlant = new History(data);
	try {
		await newPlant.save();
	} catch (err) {
		console.log(err);
	}
	return newPlant;
};

const getHistory = async (plantId) => {
	const plant = await History.findById(plantId);
	return plant;
};
export default {
	addNewHistory,
    getHistory
};
