import { Router } from "express";
import { index, reviewSummary, reviewSummaryWithTools, show } from '../controllers/products.controller.js';
import validateId from '../middlewares/validateId.js';

const router = Router();

router.get('/', index);
router.get('/:id', validateId, show);
router.get('/:id/summary', validateId, reviewSummaryWithTools);

export default router;
