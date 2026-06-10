import { Router } from "express";
import { create, destroy, index, show, update } from '../controllers/reviews.controller.js';
import validateId from '../middlewares/validateId.js';
import validateReviewBody from '../middlewares/validateReviewBody.js';

const router = Router();

router.get('/', index);
router.get('/:id', validateId, show);
router.post('/', validateReviewBody, create);
router.patch('/:id', validateId, update);
router.delete('/:id', validateId, destroy);

export default router;
