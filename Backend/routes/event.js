import express from 'express';

import { addNewEvent, getAllEvents, getEventById, updateEvent } from '../controller/event.js'
import { protect } from '../middlewares/auth.js';

const router = express.Router();


router.post('/add-new-event', protect, addNewEvent);
router.put('/update-event/:eventId', protect, updateEvent);
router.get('/get-all-events', protect, getAllEvents);
router.get('/get-event-by-id/:eventId', protect, getEventById);


export default router;
