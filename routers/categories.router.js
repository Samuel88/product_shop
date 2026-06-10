import { Router } from 'express';
import { index, show } from '../controllers/categories.controller.js';
import validateId from '../middlewares/validateId.js';

const router = Router();

router.get('/', index);
router.get('/:id', validateId, show);

export default router;
