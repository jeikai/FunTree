const express = require('express');
const app = express();
const cors = require('cors');
const dotenv = require('dotenv');
dotenv.config();
const PORT = process.env.PORT || 5000;
const routers = require('./routes');
app.use(express.json());
app.use(cors());
app.use(
	express.urlencoded({
		extended: true,
	})
);
app.use(routers);
const server = app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
})

