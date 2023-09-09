// Import asyncHandler to handle asynchronous operations
import asyncHandler from '../middlewares/async.js';
import User from '../model/user.js'
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
        token
    })
}