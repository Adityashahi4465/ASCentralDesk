import express from 'express';

import { addNewComplaint, getAllComplaints, updateComplaint, getBookmarkedComplaints, getComplaintById } from '../controller/complaint.js'
import { protect } from '../middlewares/auth.js';

const router = express.Router();


router.post('/add-new-complaint', protect, addNewComplaint);
router.get('/get-all-complaints', protect, getAllComplaints);
router.get('/get-bookmarked-complaints/:userId', protect, getBookmarkedComplaints);
router.get('/get-complaint-by-id/:complaintId', protect, getComplaintById);
router.put('/update-complaint/:id', updateComplaint);


export default router;
