-- Query to verify that challenges exist for all 10 difficulty levels
-- Run this in your Supabase SQL Editor

-- Check the distribution of challenges across difficulty levels
SELECT 
    difficulty_level,
    grade_level,
    topic,
    is_exam,
    COUNT(*) as challenge_count,
    STRING_AGG(id, ', ') as challenge_ids
FROM challenges
WHERE is_exam = false
GROUP BY difficulty_level, grade_level, topic, is_exam
ORDER BY grade_level, difficulty_level;

-- Check for missing difficulty levels (1-10) for each grade
WITH expected_levels AS (
    SELECT generate_series(1, 10) as difficulty_level
),
grade_levels AS (
    SELECT DISTINCT grade_level FROM challenges
)
SELECT 
    gl.grade_level,
    el.difficulty_level,
    CASE 
        WHEN c.id IS NULL THEN 'MISSING'
        ELSE 'EXISTS'
    END as status,
    COUNT(c.id) as challenge_count
FROM grade_levels gl
CROSS JOIN expected_levels el
LEFT JOIN challenges c 
    ON c.grade_level = gl.grade_level 
    AND c.difficulty_level = el.difficulty_level
    AND c.is_exam = false
GROUP BY gl.grade_level, el.difficulty_level, c.id
ORDER BY gl.grade_level, el.difficulty_level;

-- Count questions per challenge to ensure adequate content
SELECT 
    c.id as challenge_id,
    c.difficulty_level,
    c.grade_level,
    c.topic,
    COUNT(q.id) as question_count
FROM challenges c
LEFT JOIN questions q ON q.challenge_id = c.id
WHERE c.is_exam = false
GROUP BY c.id, c.difficulty_level, c.grade_level, c.topic
ORDER BY c.grade_level, c.difficulty_level;
