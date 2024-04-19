const mongoose = require('mongoose')
const Schema = mongoose.Schema

const ForecastSchema = new Schema({
	nextWateringAmount: {
		type: Number,
		required: true,
        default: 0
	},
    nextFertilizeAmount: {
		type: Number,
		required: true,
        default: 0
	},
	nextDateCare: Date
});

const Forecast = mongoose.model('Forecast', ForecastSchema, 'forecasts');
exports.schema = Forecast

const addNewForecast = async (plantData) => {
    const data = {
        nextWateringAmount: plantData.nextWateringAmount,
        nextFertilizeAmount: plantData.nextFertilizeAmount,
        nextDateCare: new Date()
    }
	const newPlant = new Forecast(data);
	try {
		await newPlant.save();
	} catch (err) {
		console.log(err);
	}
	return newPlant;
};

const getForecast = async (plantId) => {
	const plant = await Forecast.findById(plantId);
	return plant;
};
export default {
	addNewForecast,
    getForecast
};
