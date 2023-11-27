import Notice from '../model/notice.js';
import asyncHandler from '../middlewares/async.js';
import ErrorResponse from '../utils/errorResponse.js';
import User from '../model/user.js'
export const addNewNotice = asyncHandler(async (req, res, next) => {
    try {
        // Create a new Notice instance with all data from req.body
        const { title, category, postedAt, expirationDate, startDate, author, content, targetCampuses, priorityLevel, status, visibility, relatedNotices, tags, approvalStatus, authorContact, lastModified } = req.body;

        // Create a new Notice instance
        const newNotice = new Notice({
            title,
            category,
            postedAt,
            expirationDate,
            startDate,
            author,
            content,
            targetCampuses,
            priorityLevel,
            status,
            visibility,
            relatedNotices,
            tags,
            approvalStatus,
            authorContact,
            lastModified,
        });

        // Save the new Notice to the database
        const savedNotice = await newNotice.save();

        res.status(200).json({
            success: true,
            data: savedNotice,
        });
    } catch (error) {
        // Handle any errors that occur during the save process
        console.error('Error saving Notice:', error);
        res.status(500).json({
            success: false,
            error: 'Internal Server Error',
        });
    }
});


export const getAllNotices = asyncHandler(async (req, res, next) => {
    const Notices = await Notice.find(); // Fetch all Notices from MongoDB
    res.status(200).json({
        success: true,
        notices: Notices
    });
});


// @desc Get Bookmarks
// @route GET/api/v1/Notice/get-bookmarked-Notices:id
// @access Private
export const getBookmarkedNotices = asyncHandler(async (req, res, next) => {
    const userId = req.params.userId; // Get userId from the route parameter
    // Populate the 'bookmarkedNotices' field with actual Notice documents.
    // This allows us to retrieve the complete Notice details associated with the user.
    const user = await User.findById(userId).populate({
        path: 'bookmarkedNotices',
        model: Notice
    });

    if (!user) {
        return next(new ErrorResponse(`User with id ${userId} not found`, 404));
    }

    const bookmarkedNotices = user.bookmarkedNotices.map(Notice => Notice.toObject());

    console.log(bookmarkedNotices);
    res.status(200).json({
        success: true,
        Notices: bookmarkedNotices
    });
});

// @desc Get A Notice By It's Id
// @route GET/api/v1/Notice/get-Notice-by-id:noticeId
// @access Private
export const getNoticeById = asyncHandler(async (req, res, next) => {
    const noticeId = req.params.noticeId;

    const notice = await Notice.findById(noticeId);

    if (!notice) {
        return next(new ErrorResponse(`Notice with id ${noticeId} not found`, 404));
    }


    console.log(notice);
    res.status(200).json({
        success: true,
        notice: notice
    });
});



// @desc Update a Notice
// @route PUT /api/v1/notice/:id
// @access Private

export const updateNotice = asyncHandler(async (req, res, next) => {
    let Notice = await Notice.findById(req.params.id);
    if (!Notice) {
        return next(new ErrorResponse(`No Notice with id of ${req.params.id}`, 404))
    }


    // //bootcamp can updated by only owner
    // if (course?.user !== req.user.id && req.user.role !== 'admin') {
    //     return next(new ErrorResponse(`User ${req.user.id} is not authorized to update Notice ${course._id}`, 401));
    // }
    Notice = await Notice.updateOne({ _id: req.params.id }, req.body, {
        new: true,
        runValidators: true
    })
    res.status(200).json({
        success: true,
        data: Notice
    })
});
