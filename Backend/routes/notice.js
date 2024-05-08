import express from 'express';

import { addNewNotice, getAllNotices, getBookmarkedNotices, getNoticeById } from '../controller/notice.js'
import { protect } from '../middlewares/auth.js';

const router = express.Router();


router.post('/add-new-notice', protect, addNewNotice);
router.get('/get-all-notices', protect, getAllNotices);
router.get('/get-notice-by-id/:noticeId', protect, getNoticeById);
router.get('/get-bookmarked-notices/:userId', protect, getBookmarkedNotices);
// router.put('/update-notice/:id', updateNotice);


export default router;
