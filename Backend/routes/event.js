import express from 'express';

import { addNewEvent } from '../controller/event.js'
import { protect } from '../middlewares/auth.js';

const router = express.Router();


router.post('/add-new-event', protect, addNewEvent);


export default router;
