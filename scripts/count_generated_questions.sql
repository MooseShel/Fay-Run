-- Count questions per challenge for the generated curriculum
SELECT 
    c.id,
    c.topic,
    c.grade_level,
    c.difficulty_level,
    COUNT(q.id) as question_count
FROM challenges c
LEFT JOIN questions q ON c.id = q.challenge_id
WHERE c.id LIKE 'gen_%'
GROUP BY c.id, c.topic, c.grade_level, c.difficulty_level
ORDER BY c.grade_level, c.difficulty_level;

-- Summary counts
SELECT 
    COUNT(DISTINCT c.id) as total_challenges,
    COUNT(q.id) as total_questions
FROM challenges c
LEFT JOIN questions q ON c.id = q.challenge_id
WHERE c.id LIKE 'gen_%';
