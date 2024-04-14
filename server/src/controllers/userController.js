const userModel = require('../model/User')
const bcrypt = require('bcryptjs')
const validator = require('validator');
exports.register = async function (req, res) {
    try {
        const data = req.body;
        if (!validator.isEmail(data.email)) {
            return res.status(400).json({ message: 'Invalid email format' });
        }
        const checkUser = await userModel.get(data)
        if (checkUser) return res.status(400).json({ message: "Account existed" })

        const newUser = await userModel.create(data)
        return res.status(200).json({
            message: 'Register successfully',
            account: newUser
        })
    } catch (e) {
        return res.status(500).json({ message: e.message })
    }
}

exports.login = async function (req, res) {
    try {
        const data = req.body

        const checkUser = await userModel.get(data)
        if (!checkUser) return res.status(400).json({ message: "Account not exist" })

        const checkPassword = await bcrypt.compare(data.password, checkUser.password)
        if (!checkPassword) return res.status(400).json({ message: "Incorrect email or password" })

        return res.status(200).json({
            message: 'Login successfully',
            account: checkUser
        })
    } catch (e) {
        return res.status(500).json({ message: e.message })
    }
}

exports.getUser = async function (req, res) {
    try {
        const userId = req.params.userId
        const data = { id: userId }

        const result = await userModel.get(data)
        if (result.error) return res.status(500).json({ message: "Failed to find" })
        return res.status(200).json(result)

    } catch (e) {
        return res.status(500).json({ message: e.message })
    }
}