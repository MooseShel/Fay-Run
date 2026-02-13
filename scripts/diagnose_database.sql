-- Diagnostic queries to check current database state

-- 1. Count questions by grade and difficulty
SELECT 
    c.grade_level,
    c.difficulty_level,
    COUNT(q.id) as question_count
FROM challenges c
LEFT JOIN questions q ON c.id = q.challenge_id
WHERE c.is_exam = FALSE
GROUP BY c.grade_level, c.difficulty_level
ORDER BY c.grade_level, c.difficulty_level;

-- 2. Total counts
SELECT 
    (SELECT COUNT(*) FROM challenges WHERE is_exam = FALSE) as total_challenges,
    (SELECT COUNT(*) FROM questions WHERE challenge_id IN (SELECT id FROM challenges WHERE is_exam = FALSE)) as total_questions;

-- 3. Check for any error-prone challenge IDs
SELECT id, topic, grade_level, difficulty_level 
FROM challenges 
WHERE is_exam = FALSE
ORDER BY grade_level, difficulty_level
LIMIT 20;
