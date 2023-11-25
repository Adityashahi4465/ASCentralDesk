
import mongoose from 'mongoose'

const Schema = mongoose.Schema;

const eventSchema = new Schema({

    title: {
        type: String,
        required: true,
    },
    subtitle: String,
    description: String,
    campus: String,
    postedAt: {
        type: Date,
        required: true,
    },
    venueType: String,
    startDate: {
        type: Date,
        required: true,
    },
    endDate: Date,
    tags: [String],
    capacity: {
        type: Number,
        required: true,
    },
    eventImages: [String],
    organizerInfo: String,
    attendees: [
        {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User', // Assuming you have a User model for createdBy
            required: false,
        }
    ],
    registrationLink: String,
    contactInfo: String,
    eventType: String,
    location: String,
    feedback: [Number],
});

const Event = mongoose.model('Event', eventSchema);

export default Event;
