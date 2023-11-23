import Complaint from '../model/complaint.js';
import asyncHandler from '../middlewares/async.js';
import ErrorResponse from '../utils/errorResponse.js';
import User from '../model/user.js'
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


// @desc Update a Courses
// @route GET/api/v1/complaint/get-bookmarked-complaints:id
// @access Private
export const getBookmarkedComplaints = asyncHandler(async (req, res, next) => {
    const userId = req.params.userId; // Get userId from the route parameter
    // Populate the 'bookmarkedComplaints' field with actual Complaint documents.
    // This allows us to retrieve the complete Complaint details associated with the user.
    const user = await User.findById(userId).populate({
        path: 'bookmarkedComplaints',
        model: Complaint
    });

    if (!user) {
        return next(new ErrorResponse(`User with id ${userId} not found`, 404));
    }

    const bookmarkedComplaints = user.bookmarkedComplaints.map(complaint => complaint.toObject());

    console.log(bookmarkedComplaints);
    res.status(200).json({
        success: true,
        complaints: bookmarkedComplaints
    });
});



// @desc Update a Compliant
// @route PUT /api/v1/complaint/:id
// @access Private

export const updateComplaint = asyncHandler(async (req, res, next) => {
    let complaint = await Complaint.findById(req.params.id);
    if (!complaint) {
        return next(new ErrorResponse(`No complaint with id of ${req.params.id}`, 404))
    }


    // //bootcamp can updated by only owner
    // if (course?.user !== req.user.id && req.user.role !== 'admin') {
    //     return next(new ErrorResponse(`User ${req.user.id} is not authorized to update complaint ${course._id}`, 401));
    // }
    complaint = await Complaint.updateOne({ _id: req.params.id }, req.body, {
        new: true,
        runValidators: true
    })
    res.status(200).json({
        success: true,
        data: complaint
    })
});
