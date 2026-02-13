-- ========================================================
-- DATABASE INTEGRITY FIX
-- Sets is_exam = FALSE for challenges that were accidentally
-- marked as exams but have no name (e.g. academic pool defaults).
-- ========================================================

BEGIN;

UPDATE challenges 
SET is_exam = FALSE 
WHERE is_exam = TRUE 
AND (exam_name IS NULL OR exam_name = '');

COMMIT;
