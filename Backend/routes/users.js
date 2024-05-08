import express from 'express'
import {
    createUser,
    deleteUser,
    getUser,
    updateUser
} from '../controller/users.js';
import { protect } from '../middlewares/auth.js';
const router = express.Router();

//all routes below it will use protect and authorize
router.use(protect);


router.route('/:id').get(getUser).delete(deleteUser).put(updateUser).post(createUser);

export default router;