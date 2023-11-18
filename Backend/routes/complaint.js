import express from 'express';

import { addNewComplaint, getAllComplaints } from '../controller/complaint.js'
import { protect } from '../middlewares/auth.js';

const router = express.Router();


router.post('/add-new-complaint', protect, addNewComplaint);
router.get('/get-all-complaints', protect, getAllComplaints);


export default router;
