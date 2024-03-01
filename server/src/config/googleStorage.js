import { Storage } from '@google-cloud/storage';

const storage = () => {
	try {
		const ggStorage = new Storage({
			keyFilename: 'FunTree IAM.json',
            projectId: 'funtree-415017',
		});
		console.log('Init storage success!');
		return ggStorage;
	} catch (error) {
		console.log('Error init storage', error);
		return null;
	}
};

export default storage;
