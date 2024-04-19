const cloudinary = require('cloudinary').v2;
const { CloudinaryStorage } = require('multer-storage-cloudinary');
const multer = require('multer');
require('dotenv').config()

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_NAME, //dzgo9ntnw
  api_key: process.env.CLOUDINARY_KEY, //658824436727781
  api_secret: process.env.CLOUDINARY_SECRET // EZ5UBYBMqbbcvkAp8vdfhXi2DF4
}); 

const storage = new CloudinaryStorage({
  cloudinary,
  allowedFormats: ['jpg', 'png'],
});

const uploadCloud = multer({ storage });

module.exports = uploadCloud;
