const mongoose = require('mongoose')
const { userInfo } = require('os')
const Schema = mongoose.Schema

const RoomSchema = new Schema({
    userId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', default: ''},
    type: { type: String, required: true },
    listPlant: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Plant', default: ''}],
    date_created: Date,
    date_updated: Date
})

const Room = mongoose.model('Room', RoomSchema, 'rooms')
exports.schema = Room

exports.create = async function (data) {
    try {
        const roomData = {
            userId: data.userId,
            type: data.type,
            date_created: new Date(),
            date_updated: new Date()
        }
        const newRoom = User(roomData)
        await newRoom.save()
        return newRoom
    } catch (e) {
        return { error: e }
    }
}

exports.get = async function (data) {
    try {
        let query = {}
        if (data.id) query._id = data.id
        const room = await Room.findOne(query).lean().populate("listPlant")
        return room
    } catch (e) {
        return { error: e }
    }
}

exports.update = async function (roomId, data) {
    try {
        const result = await Room.findByIdAndUpdate(roomId, data)
        return await Room.findById(result._id)
    } catch (e) {
        return { error: e }
    }
}

exports.getAll = async function () {
    try {
        const users = await Room.find({});
        return users;
    } catch (e) {
        return { error: e };
    }
};
