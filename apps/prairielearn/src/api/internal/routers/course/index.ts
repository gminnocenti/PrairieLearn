import { router } from '../../trpc.js';

import { createQuestion } from './createQuestion.js';
import { updateQuestionFiles } from './updateQuestionFiles.js';

export const courseRouter = router({
  createQuestion,
  updateQuestionFiles,
});
