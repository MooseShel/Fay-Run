-- Fay Gator Run - Verify Exam Data
-- This query shows all exams, their topics, grades, and how many questions are linked to them.

SELECT 
    c.grade_level,
    c.topic,
    c.exam_name,
    COUNT(q.id) as question_count
FROM 
    challenges c
LEFT JOIN 
    questions q ON c.id = q.challenge_id
WHERE 
    c.is_exam = TRUE
GROUP BY 
    c.grade_level, c.topic, c.exam_name, c.id
ORDER BY 
    c.grade_level ASC, c.topic ASC;
