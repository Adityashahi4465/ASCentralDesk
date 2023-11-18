import Complaint from '../model/complaint.js';
import asyncHandler from '../middlewares/async.js';
import ErrorResponse from '../utils/errorResponse.js';

export const addNewComplaint = asyncHandler(async (req, res, next) => {
    // Assuming you have a Complaint schema with fields like title, description, images, etc.
    const { title, description, images, filingTime, status, createdBy, category } = req.body;

    try {
        // Create a new Complaint instance
        const newComplaint = new Complaint({
            title,
            description,
            filingTime,
            status,
            images,
            createdBy,
            category,
        });

        // Save the new Complaint to the database
        const savedComplaint = await newComplaint.save();

        res.status(200).json({
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


export const getAllComplaints = asyncHandler(async (req, res, next) => {
    const complaints = await Complaint.find(); // Fetch all complaints from MongoDB
    res.status(200).json({
        success: true,
        complaints: complaints
    });
});
