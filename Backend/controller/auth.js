// Import asyncHandler to handle asynchronous operations
import asyncHandler from '../middlewares/async.js';
import User from '../model/user.js'
import ErrorResponse from '../utils/errorResponse.js';
import sendEmail from '../utils/sandMail.js';
import jwt from 'jsonwebtoken';


// @desc Register user
// @route POST /api/v1/auth/register
// @access Public

// Define the register function, which is an asynchronous function that handles user registration
export const register = asyncHandler(async (req, res, next) => {
    /*  Steps for registration
     1. Extract User Input
     2. Look for any existing user
     3. Hash/Encrypt password
     4. Create User Model
     5. Throw any server error 
     6. Connect to Client Side
    */
    // Destructure data from the request body
    const { name, email, password, role, rollNo, campus, course, semester } = req.body;
    console.log("fseref");
    // Create a new user in the database with all validations such as duplicate users.
    const user = await User.create({
        name,
        email,
        password,
        role,
        rollNo,
        campus,
        course,
        semester,
    });

    // Call a function to send a token response to the client
    sendTokenResponse(user, 200, res);

});

// @desc Register user
// @route POST /api/v1/auth/login
// @access Public

export const login = asyncHandler(async (req, res, next) => {
    const { email, password } = req.body;
    console.log("login");

    //Validate Email and Password
    if (!email || !password) {
        return next(new ErrorResponse(`Please provide all details required for login`, 400));
    }

    //Check for User
    const user = await User.findOne({ email }).select('+password');
    if (!user) {
        return next(new ErrorResponse(`Invalid Credentials !!!`, 401));
    }

    //Check if password matches:
    const isMatch = await user.matchPassword(password);

    if (!isMatch) {
        return next(new ErrorResponse(`Invalid Credentials !!!`, 401));
    }

    sendTokenResponse(user, 200, res);

});


// Route to send a verification email
export const sandEmailVerification = asyncHandler(async (req, res, next) => {

    const user = await User.findOne({ email: req.body.email });
    if (!user) {
        return next(new ErrorResponse(`Email not registered !!!`, 401));
    }

    try {
        // Generate a unique verification token
        const email = user.email;
        const verificationToken = jwt.sign({ email }, process.env.JWT_SECRET, { expiresIn: '10m' });
        // Create a verification link
        const verificationLink = `${req.protocol}://${req.get('host')}/api/v1/auth/verify/${verificationToken}`;

        // Send the email   
        const info = await sendEmail({
            name: req.get('host'),
            email: user.email,
            subject: `Email Verification`,
            message: `Click the following link to verify your email: ${verificationLink}`,
        });
        res.status(200).json({ success: true, data: `email sent ${info}` })
    } catch (error) {
        console.error(error);
        return next(new ErrorResponse(`Email could not be sent ${error}`, 500));
    }
});




// Route to handle email verification from the web page
export const verifyEmail = asyncHandler(async (req, res) => {
    // console.log('req.params:', req.params); // Log the URL parameters
    const token = req.params.verificationToken;
    console.log(token);
    if (!token) {
        return res.status(400).json({ message: 'Missing verification token' });
    }

    try {
        // Verify the token
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        console.log(decoded);
        // Extract the email from the decoded token
        const { email } = decoded;

        // Check if the email exists in the database
        const user = await User.findOne({ email });

        if (!user) {
            return res.status(400).json({ message: 'User not found' });
        }

        // Check if the user's email has already been verified
        if (user.emailVerified) {
            return res.status(400).json({ message: 'Email already verified' });
        }

        // Update the user's email verification status in your MongoDB database
        user.emailVerified = true;
        await user.save();

        return res.status(200).json({ message: 'Email verified successfully' });
    } catch (error) {
        console.error(error);
        return res.status(400).json({ message: 'Email verification failed' });
    }
});





// Get token from model, create cookie and send response

const sendTokenResponse = async (user, statusCode, res) => {
    //Create Token
    const token = user.getJWTSignedToken();

    //Create cookie
    const options = {
        expires: new Date(Date.now() + process.env.JWT_COOKIE_EXPIRE * 24 * 60 * 60 * 1000),
        httpOnly: true,
    };

    if (process.env.NODE_ENV === 'production') {
        options.secure = true;
    }
    //sending both token and cookie, depend on client, whether to store token in local storage or use cookie
    res.status(statusCode).cookie('token', token, options).json({
        success: true,
        token,
        user
    })
}

export const getMe = asyncHandler(async (req, res, next) => {
    const user = await User.findById(req.user.id);
    res.status(200).json({
        success: true,
        user: user
    })
});

