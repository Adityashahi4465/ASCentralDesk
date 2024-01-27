// Import the Express framework
import express from 'express';
// Import the "register" function from the auth controller
import {
    register,
    getMe,
    login,
    verifyEmail,
    sandEmailVerification,
} from '../controller/auth.js';
import { protect } from '../middlewares/auth.js';
// Create a new Express Router instance
const router = express.Router();

// Define a POST route for user registration, register function will be executed given in 2nd parameter
router.post('/register', register);
router.post('/login', login);
router.post('/send-verification-email', sandEmailVerification);
router.get('/verify/:verificationToken', verifyEmail);
router.get('/me', protect, getMe);



// Export the router so it can be used in other parts of the application
export default router;
