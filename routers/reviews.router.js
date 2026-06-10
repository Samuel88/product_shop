import { Router } from "express";
import { create, destroy, index, show, update } from '../controllers/reviews.controller.js';

const router = Router();

router.get('/', index);
router.get('/:id', show);
router.post('/', create);
router.patch('/:id', update);
router.delete('/:id', destroy);

export default router;