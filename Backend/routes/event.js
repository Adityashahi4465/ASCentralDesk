import express from 'express';

import { addNewEvent, getAllEvents } from '../controller/event.js'
import { protect } from '../middlewares/auth.js';

const router = express.Router();


router.post('/add-new-event', protect, addNewEvent);
router.post('/get-all-events', protect, getAllEvents);


export default router;
