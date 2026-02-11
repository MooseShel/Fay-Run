-- Exam Questions for Math, Science, and Social Studies
-- Difficulty Levels 1-5

-- ========================================
-- MATH EXAM
-- ========================================

-- Difficulty 1
INSERT INTO challenges (id, topic, season, week_number, grade_level, difficulty_level, is_exam) 
VALUES ('exam_math_d1', 'Math', 'Exam_2025', 99, 4, 1, TRUE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
VALUES ('q_math_exam_d1_1', 'exam_math_d1', '100 + 200 = ?', '300', '200', '400');
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
VALUES ('q_math_exam_d1_2', 'exam_math_d1', '10 x 5 = ?', '50', '40', '60');

-- Difficulty 3
INSERT INTO challenges (id, topic, season, week_number, grade_level, difficulty_level, is_exam) 
VALUES ('exam_math_d3', 'Math', 'Exam_2025', 99, 4, 3, TRUE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
VALUES ('q_math_exam_d3_1', 'exam_math_d3', 'What is 15 x 6?', '90', '80', '100');
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
VALUES ('q_math_exam_d3_2', 'exam_math_d3', 'Simplify 4/8', '1/2', '1/4', '3/4');

-- Difficulty 5
INSERT INTO challenges (id, topic, season, week_number, grade_level, difficulty_level, is_exam) 
VALUES ('exam_math_d5', 'Math', 'Exam_2025', 99, 4, 5, TRUE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
VALUES ('q_math_exam_d5_1', 'exam_math_d5', 'What is 25^2?', '625', '525', '725');
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
VALUES ('q_math_exam_d5_2', 'exam_math_d5', 'Value of Pi (2 decimals)?', '3.14', '3.12', '3.16');

-- ========================================
-- SCIENCE EXAM
-- ========================================

-- Difficulty 1
INSERT INTO challenges (id, topic, season, week_number, grade_level, difficulty_level, is_exam) 
VALUES ('exam_sci_d1', 'Science', 'Exam_2025', 99, 4, 1, TRUE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
VALUES ('q_sci_exam_d1_1', 'exam_sci_d1', 'What do plants need to grow?', 'Water and Sun', 'Candy', 'Rocks');

-- Difficulty 5
INSERT INTO challenges (id, topic, season, week_number, grade_level, difficulty_level, is_exam) 
VALUES ('exam_sci_d5', 'Science', 'Exam_2025', 99, 4, 5, TRUE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
VALUES ('q_sci_exam_d5_1', 'exam_sci_d5', 'Powerhouse of the cell?', 'Mitochondria', 'Nucleus', 'Wall');
