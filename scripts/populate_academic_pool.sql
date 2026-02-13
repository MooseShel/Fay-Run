-- =============================================================
-- Fay Gator Run: Academic Question Pool (Linear Difficulty 1-10)
-- Topics: Math, Science, Social Studies
-- Includes both Normal and Exam challenges
-- =============================================================

-- Populate Challenges (Grade 4 example)
-- Normal Challenges (Difficulty 1-10)
-- Normal Challenges (Difficulty 1-10)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES
('ch_g4_math_d1', 'Math', 4, 1, false),
('ch_g4_math_d2', 'Math', 4, 2, false),
('ch_g4_math_d3', 'Math', 4, 3, false),
('ch_g4_math_d4', 'Math', 4, 4, false),
('ch_g4_math_d5', 'Math', 4, 5, false),
('ch_g4_math_d6', 'Math', 4, 6, false),
('ch_g4_math_d7', 'Math', 4, 7, false),
('ch_g4_math_d8', 'Math', 4, 8, false),
('ch_g4_math_d9', 'Math', 4, 9, false),
('ch_g4_math_d10', 'Math', 4, 10, false),

-- Exam Challenges (Difficulty 1-10)
('exam_g4_math_d1', 'Math', 4, 1, true),
('exam_g4_math_d3', 'Math', 4, 3, true),
('exam_g4_math_d5', 'Math', 4, 5, true),
('exam_g4_math_d7', 'Math', 4, 7, true),
('exam_g4_math_d10', 'Math', 4, 10, true),

-- Science Challenges
('ch_g4_sci_d1', 'Science', 4, 1, false),
('ch_g4_sci_d5', 'Science', 4, 5, false),
('ch_g4_sci_d10', 'Science', 4, 10, false),

-- Social Studies Challenges
('ch_g4_soc_d1', 'Social Studies', 4, 1, false),
('ch_g4_soc_d5', 'Social Studies', 4, 5, false),
('ch_g4_soc_d10', 'Social Studies', 4, 10, false)
ON CONFLICT (id) DO UPDATE SET 
  topic = EXCLUDED.topic,
  difficulty_level = EXCLUDED.difficulty_level,
  is_exam = EXCLUDED.is_exam;

-- Populate Questions (Consolidated into one statement)
-- Populate Questions (Consolidated into one statement)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
-- Math Difficulty 1 (Expanded for consistency/plenty)
('q_m_d1_1', 'ch_g4_math_d1', 'What is 3 + 5?', '8', '7', '9'),
('q_m_d1_2', 'ch_g4_math_d1', 'What is 10 - 2?', '8', '7', '9'),
('q_m_d1_3', 'ch_g4_math_d1', 'What is 4 + 6?', '10', '9', '11'),
('q_m_d1_4', 'ch_g4_math_d1', 'What is 7 - 3?', '4', '3', '5'),
('q_m_d1_5', 'ch_g4_math_d1', 'What is 2 + 9?', '11', '10', '12'),
('q_ex_m_d1_1', 'exam_g4_math_d1', '[EXAM] What is 4 + 4?', '8', '7', '9'),
('q_ex_m_d1_2', 'exam_g4_math_d1', '[EXAM] What is 12 - 4?', '8', '7', '9'),

-- Math Difficulty 5
('q_m_d5_1', 'ch_g4_math_d5', 'What is 5 x 5?', '25', '20', '30'),
('q_m_d5_2', 'ch_g4_math_d5', 'What is 100 / 4?', '25', '20', '30'),
('q_m_d5_3', 'ch_g4_math_d5', 'What is 8 x 4?', '32', '30', '34'),
('q_ex_m_d5_1', 'exam_g4_math_d5', '[EXAM] What is 12 x 5?', '60', '50', '70'),

-- Math Difficulty 10
('q_m_d10_1', 'ch_g4_math_d10', 'What is 12 x 12?', '144', '124', '134'),
('q_m_d10_2', 'ch_g4_math_d10', 'Find X: X + 10 = 30', '20', '10', '30'),
('q_m_d10_3', 'ch_g4_math_d10', 'What is 25 x 4?', '100', '90', '110'),
('q_ex_m_d10_1', 'exam_g4_math_d10', '[EXAM] What is 15 x 10?', '150', '140', '160'),

-- Science Difficulty 1
('q_s_d1_1', 'ch_g4_sci_d1', 'Which planet is the Red Planet?', 'Mars', 'Venus', 'Jupiter'),
('q_s_d1_2', 'ch_g4_sci_d1', 'What do plants need most?', 'Sunlight', 'Milk', 'Bread'),
('q_s_d1_3', 'ch_g4_sci_d1', 'Which animal is a mammal?', 'Dog', 'Shark', 'Ant'),

-- Social Studies Difficulty 1
('q_ss_d1_1', 'ch_g4_soc_d1', 'Who was the first U.S. President?', 'George Washington', 'Abraham Lincoln', 'John Adams'),
('q_ss_d1_2', 'ch_g4_soc_d1', 'What is the capital of the USA?', 'Washington D.C.', 'New York', 'Dallas'),
('q_ss_d1_3', 'ch_g4_soc_d1', 'Who is on the $1 bill?', 'George Washington', 'Ben Franklin', 'Thomas Jefferson')

ON CONFLICT (id) DO UPDATE SET
  question_text = EXCLUDED.question_text,
  correct_option = EXCLUDED.correct_option,
  wrong_option_1 = EXCLUDED.wrong_option_1,
  wrong_option_2 = EXCLUDED.wrong_option_2;
