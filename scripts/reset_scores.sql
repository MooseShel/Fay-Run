-- Fay Gator Run - Reset All Scores
-- This script resets all student high scores to 0 and clears the progress history
-- Use this when standardizing the scoring system to ensure a fresh start.

-- 1. Reset high scores in the students table
UPDATE students SET high_score = 0;

-- 2. Clear all student progress records
-- This ensures the leaderboard is fresh and reflects the new scoring system
DELETE FROM student_progress;

-- 3. (Optional) Reset max level if you want everyone to start from Level 1
-- UPDATE students SET max_level = 1;
