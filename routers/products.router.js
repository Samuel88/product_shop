import { Router } from "express";
import { index, show } from '../controllers/products.controller.js';

const router = Router();

router.get('/', index);
router.get('/:id', show);

export default router;