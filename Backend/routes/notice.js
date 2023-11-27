import express from 'express';

import { addNewNotice } from '../controller/notice.js'
import { protect } from '../middlewares/auth.js';

const router = express.Router();


router.post('/add-new-notice', protect, addNewNotice);
// router.get('/get-all-notices', protect, getAllnotices);
// router.get('/get-bookmarked-notices/:userId', protect, getBookmarkednotices);
// router.get('/get-notice-by-id/:noticeId', protect, getnoticeById);
// router.put('/update-notice/:id', updatenotice);


export default router;
