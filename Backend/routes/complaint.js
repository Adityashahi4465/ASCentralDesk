import express from 'express';

import { addNewComplaint } from '../controller/complaint.js'
import { protect } from '../middlewares/auth.js';

const router = express.Router();


router.post('/add-new-complaint', protect, addNewComplaint);


export default router;
