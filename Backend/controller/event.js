import asyncHandler from '../middlewares/async.js';
import ErrorResponse from '../utils/errorResponse.js';
import User from '../model/user.js'
import Event from '../model/event.js'
export const addNewEvent = asyncHandler(async (req, res, next) => {
    // Assuming you have a Complaint schema with fields like title, description, images, etc.
    try {
        // Extract event details from the request body
        const {

            title,
            subtitle,
            description,
            campus,
            postedAt,
            venueType,
            startDate,
            endDate,
            tags,
            capacity,
            eventImages,
            organizerInfo,
            attendees,
            registrationLink,
            contactInfo,
            eventType,
            location,
            feedback,
        } = req.body;

        // Create a new Event instance
        const newEvent = new Event({

            title,
            subtitle,
            description,
            campus,
            postedAt,
            venueType,
            startDate,
            endDate,
            tags,
            capacity,
            eventImages,
            organizerInfo,
            attendees,
            registrationLink,
            contactInfo,
            eventType,
            location,
            feedback,
        });

        // Save the event to the database
        const savedEvent = await newEvent.save();
        console.log('Event Saved: ', savedEvent);
        res.status(200).json({
            success: true,
            data: savedEvent,
        });
    } catch (error) {
        console.error('Error saving event:', error);
        res.status(500).json({
            success: false,
            error: 'Internal Server Error',
        });
    }
});