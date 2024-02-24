export const getWateringData = async (req, res) => {
	const { temperature: T, aqi: A } = await req.query;
	const current_date = new Date();
	const currentMonth = new Date().getMonth() + 1;

	const ET = 0.0023 * 14.22 * (T + 17.8) * (Math.sqrt(T) - Math.sqrt(15));

	const ETo = [2.0, 2.4, 2.5, 2.7, 4.0, 5.0, 5.3, 4.2, 4.0, 3.8, 2.8, 2.6];
	const Kc = ET / ETo[currentMonth - 1]; /* Gán giá trị cho Kc */
	console.log(currentMonth);
	console.log(1 - ETo[currentMonth - 1] / ET);
	console.log(ET * Kc * A);
	const water_amount = ET * Kc * A * (1 - ETo[currentMonth - 1] / ET);
	console.log('water_amount', water_amount);
	console.log('et', ET);
	const TAW = 1000; // Tổng lượng nước khả dụng (mm)
	const AW = 300; // Lượng nước sẵn có trong đất (mm)
	console.log((TAW - AW) / ET);

	const next_watering_date = new Date(
		current_date.setDate(current_date.getDate() + parseInt((TAW - AW) / ET))
	)
		.toISOString()
		.slice(0, 10);
	return res.status(200).json({
		water_amount: water_amount,
		next_watering_date: next_watering_date,
	});
};

const fertilizerEfficiency = (plantName, temperature) => {
	const efficiencyByPlant = {
		Tomato: 0.5,
		'Dưa chuột': 0.6,
		'Ớt chuông': 0.7,
		'Rau diếp': 0.8,
	};

	// Hiệu quả sử dụng phân bón theo nhiệt độ
	const efficiencyByTemperature = {
		'[0, 10]': 0.4,
		'[10, 20]': 0.6,
		'[20, 30]': 0.8,
		'[30, 40]': 1.0,
	};

	// Tìm hiệu quả sử dụng phân bón cho cây trồng cụ thể
	let efficiency = efficiencyByPlant[plantName] || 0.5;

	// Điều chỉnh hiệu quả theo nhiệt độ
	for (const tempRange of Object.keys(efficiencyByTemperature)) {
		const [minTemp, maxTemp] = tempRange.split(',').map(Number);
		if (minTemp <= temperature && temperature < maxTemp) {
			efficiency *= efficiencyByTemperature[tempRange];
			break;
		}
	}

	return efficiency;
};
export const getFertilizingData = async (req, res) => {
	const {
		temperature: T,
		aqi: A,
		plant_name: C,
	} = await req.query;

	switch (C) {
		case 'Tomato':
			N = data[0];
			break;
		case 'Garden Tomato':
			N = data[0];
			break;
		case 'Cucumber':
			N = data[1];
			break;
		case 'Bell Pepper':
			N = data[2];
			break;
		case 'Lettuce':
			N = data[3];
			break;
		case 'Snake Plant':
			N = data[4];
			break;
		default:
			const N = 0;

			break;
	}

	const nuptake = 0.0;
	// for (const action of pastCareData) {
	// 	if (action.action === 'fertilize') {
	// 		nuptake += (action.amount * fertilizerEfficiency('Tomato', T)) / A;
	// 	}
	// }
	const fertilizer_amount = N * A * (1 - nuptake / N);
	return res.status(200).json({
		fertilizer_amount: fertilizer_amount,
	});
};
