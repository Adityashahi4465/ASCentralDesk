import Complaint from '../model/complaint.js';
import asyncHandler from '../middlewares/async.js';
import ErrorResponse from '../utils/errorResponse.js';

export const addNewComplaint = asyncHandler(async (req, res, next) => {
    // Assuming you have a Complaint schema with fields like title, description, images, etc.
    const { title, description, images, filingTime, status } = req.body;

    try {
        // Create a new Complaint instance
        const newComplaint = new Complaint({
            title,
            description,
            filingTime,
            status,
            images, // Assuming images is an array of image bytes
            // Add other fields as needed
        });

        // Save the new Complaint to the database
        const savedComplaint = await newComplaint.save();

        res.status(201).json({
            success: true,
            data: savedComplaint,
        });
    } catch (error) {
        // Handle any errors that occur during the save process
        console.error('Error saving complaint:', error);
        res.status(500).json({
            success: false,
            error: 'Internal Server Error',
        });
    }
});
