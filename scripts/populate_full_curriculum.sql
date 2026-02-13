-- =============================================================
-- AUTOMATICALY GENERATED CURRICULUM (generate_curriculum.dart)
-- =============================================================
-- 10 Questions per Level, All Grades (-2 to 5)
-- =============================================================

BEGIN;

-- 1. CLEANUP
DELETE FROM student_progress WHERE challenge_id IN (SELECT id FROM challenges WHERE is_exam = FALSE);
DELETE FROM questions WHERE challenge_id IN (SELECT id FROM challenges WHERE is_exam = FALSE);
DELETE FROM challenges WHERE is_exam = FALSE;


-- Pre-K 3 (Grade -2)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_1', 'Math', -2, 1, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_1_1', 'gen_neg2_1', 'What is 21 - 11?', '10', '13', '8'),
('q_gen_neg2_1_2', 'gen_neg2_1', 'What is 1 + 2?', '3', '6', '0'),
('q_gen_neg2_1_3', 'gen_neg2_1', 'What is 23 - 22?', '1', '2', '3'),
('q_gen_neg2_1_4', 'gen_neg2_1', 'What is 14 - 3?', '11', '12', '10'),
('q_gen_neg2_1_5', 'gen_neg2_1', 'What is 7 + 9?', '16', '18', '14'),
('q_gen_neg2_1_6', 'gen_neg2_1', 'What is 3 + 3?', '6', '11', '1'),
('q_gen_neg2_1_7', 'gen_neg2_1', 'What is 24 - 9?', '15', '17', '14'),
('q_gen_neg2_1_8', 'gen_neg2_1', 'What is 16 - 9?', '7', '8', '4'),
('q_gen_neg2_1_9', 'gen_neg2_1', 'What is 8 + 3?', '11', '15', '6'),
('q_gen_neg2_1_10', 'gen_neg2_1', 'What is 6 - 3?', '3', '4', '1') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_2', 'Math', -2, 2, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_2_1', 'gen_neg2_2', 'What is 3 + 10?', '13', '18', '8'),
('q_gen_neg2_2_2', 'gen_neg2_2', 'What is 17 - 17?', '0', '3', '1'),
('q_gen_neg2_2_3', 'gen_neg2_2', 'What is 17 - 16?', '1', '3', '2'),
('q_gen_neg2_2_4', 'gen_neg2_2', 'What is 20 - 20?', '0', '2', '3'),
('q_gen_neg2_2_5', 'gen_neg2_2', 'What is 18 - 7?', '11', '13', '8'),
('q_gen_neg2_2_6', 'gen_neg2_2', 'What is 8 + 2?', '10', '14', '5'),
('q_gen_neg2_2_7', 'gen_neg2_2', 'What is 5 + 9?', '14', '19', '10'),
('q_gen_neg2_2_8', 'gen_neg2_2', 'What is 3 + 4?', '7', '9', '5'),
('q_gen_neg2_2_9', 'gen_neg2_2', 'What is 6 + 8?', '14', '16', '10'),
('q_gen_neg2_2_10', 'gen_neg2_2', 'What is 7 + 9?', '16', '17', '12') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_3', 'Math', -2, 3, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_3_1', 'gen_neg2_3', 'What is 9 - 8?', '1', '3', '8'),
('q_gen_neg2_3_2', 'gen_neg2_3', 'What is 24 - 5?', '19', '20', '17'),
('q_gen_neg2_3_3', 'gen_neg2_3', 'What is 4 + 5?', '9', '12', '5'),
('q_gen_neg2_3_4', 'gen_neg2_3', 'What is 3 + 1?', '4', '6', '1'),
('q_gen_neg2_3_5', 'gen_neg2_3', 'What is 1 + 5?', '6', '7', '3'),
('q_gen_neg2_3_6', 'gen_neg2_3', 'What is 8 + 9?', '17', '22', '13'),
('q_gen_neg2_3_7', 'gen_neg2_3', 'What is 7 + 1?', '8', '13', '4'),
('q_gen_neg2_3_8', 'gen_neg2_3', 'What is 3 + 10?', '13', '18', '12'),
('q_gen_neg2_3_9', 'gen_neg2_3', 'What is 4 + 6?', '10', '15', '9'),
('q_gen_neg2_3_10', 'gen_neg2_3', 'What is 24 - 4?', '20', '22', '17') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_4', 'Math', -2, 4, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_4_1', 'gen_neg2_4', 'What is 10 + 7?', '17', '22', '12'),
('q_gen_neg2_4_2', 'gen_neg2_4', 'What is 16 - 14?', '2', '4', '0'),
('q_gen_neg2_4_3', 'gen_neg2_4', 'What is 7 + 7?', '14', '16', '11'),
('q_gen_neg2_4_4', 'gen_neg2_4', 'What is 12 - 10?', '2', '3', '0'),
('q_gen_neg2_4_5', 'gen_neg2_4', 'What is 15 - 9?', '6', '7', '5'),
('q_gen_neg2_4_6', 'gen_neg2_4', 'What is 22 - 16?', '6', '7', '3'),
('q_gen_neg2_4_7', 'gen_neg2_4', 'What is 12 - 10?', '2', '5', '1'),
('q_gen_neg2_4_8', 'gen_neg2_4', 'What is 13 - 13?', '0', '1', '2'),
('q_gen_neg2_4_9', 'gen_neg2_4', 'What is 10 - 7?', '3', '6', '2'),
('q_gen_neg2_4_10', 'gen_neg2_4', 'What is 14 - 12?', '2', '4', '1') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_5', 'Science', -2, 5, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_5_1', 'gen_neg2_5', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg2_5_2', 'gen_neg2_5', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg2_5_3', 'gen_neg2_5', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg2_5_4', 'gen_neg2_5', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg2_5_5', 'gen_neg2_5', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg2_5_6', 'gen_neg2_5', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg2_5_7', 'gen_neg2_5', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg2_5_8', 'gen_neg2_5', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg2_5_9', 'gen_neg2_5', 'What is 5 - 4?', '1', '4', '8'),
('q_gen_neg2_5_10', 'gen_neg2_5', 'What is 16 - 3?', '13', '16', '12') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_6', 'Science', -2, 6, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_6_1', 'gen_neg2_6', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg2_6_2', 'gen_neg2_6', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg2_6_3', 'gen_neg2_6', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg2_6_4', 'gen_neg2_6', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg2_6_5', 'gen_neg2_6', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg2_6_6', 'gen_neg2_6', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg2_6_7', 'gen_neg2_6', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg2_6_8', 'gen_neg2_6', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg2_6_9', 'gen_neg2_6', 'What is 6 + 9?', '15', '16', '14'),
('q_gen_neg2_6_10', 'gen_neg2_6', 'What is 4 + 9?', '13', '17', '12') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_7', 'Science', -2, 7, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_7_1', 'gen_neg2_7', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg2_7_2', 'gen_neg2_7', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg2_7_3', 'gen_neg2_7', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg2_7_4', 'gen_neg2_7', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg2_7_5', 'gen_neg2_7', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg2_7_6', 'gen_neg2_7', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg2_7_7', 'gen_neg2_7', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg2_7_8', 'gen_neg2_7', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg2_7_9', 'gen_neg2_7', 'What is 3 + 2?', '5', '8', '1'),
('q_gen_neg2_7_10', 'gen_neg2_7', 'What is 9 - 6?', '3', '6', '0') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_8', 'Social Studies', -2, 8, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_8_1', 'gen_neg2_8', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_neg2_8_2', 'gen_neg2_8', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_neg2_8_3', 'gen_neg2_8', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_neg2_8_4', 'gen_neg2_8', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_neg2_8_5', 'gen_neg2_8', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_neg2_8_6', 'gen_neg2_8', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_neg2_8_7', 'gen_neg2_8', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_neg2_8_8', 'gen_neg2_8', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_neg2_8_9', 'gen_neg2_8', 'What is 18 - 5?', '13', '15', '12'),
('q_gen_neg2_8_10', 'gen_neg2_8', 'What is 8 + 1?', '9', '10', '4') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_9', 'Social Studies', -2, 9, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_9_1', 'gen_neg2_9', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_neg2_9_2', 'gen_neg2_9', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_neg2_9_3', 'gen_neg2_9', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_neg2_9_4', 'gen_neg2_9', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_neg2_9_5', 'gen_neg2_9', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_neg2_9_6', 'gen_neg2_9', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_neg2_9_7', 'gen_neg2_9', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_neg2_9_8', 'gen_neg2_9', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_neg2_9_9', 'gen_neg2_9', 'What is 8 - 1?', '7', '8', '5'),
('q_gen_neg2_9_10', 'gen_neg2_9', 'What is 8 - 8?', '0', '2', '1') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg2_10', 'Social Studies', -2, 10, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg2_10_1', 'gen_neg2_10', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_neg2_10_2', 'gen_neg2_10', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_neg2_10_3', 'gen_neg2_10', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_neg2_10_4', 'gen_neg2_10', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_neg2_10_5', 'gen_neg2_10', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_neg2_10_6', 'gen_neg2_10', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_neg2_10_7', 'gen_neg2_10', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_neg2_10_8', 'gen_neg2_10', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_neg2_10_9', 'gen_neg2_10', 'What is 7 + 1?', '8', '13', '5'),
('q_gen_neg2_10_10', 'gen_neg2_10', 'What is 5 + 4?', '9', '11', '5') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;

-- Pre-K 4 (Grade -1)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_1', 'Science', -1, 1, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_1_1', 'gen_neg1_1', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_1_2', 'gen_neg1_1', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_1_3', 'gen_neg1_1', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_1_4', 'gen_neg1_1', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_1_5', 'gen_neg1_1', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_1_6', 'gen_neg1_1', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_1_7', 'gen_neg1_1', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_1_8', 'gen_neg1_1', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_1_9', 'gen_neg1_1', 'What is 16 + 16?', '32', '35', '29'),
('q_gen_neg1_1_10', 'gen_neg1_1', 'What is 25 - 22?', '3', '4', '1') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_2', 'Science', -1, 2, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_2_1', 'gen_neg1_2', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_2_2', 'gen_neg1_2', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_2_3', 'gen_neg1_2', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_2_4', 'gen_neg1_2', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_2_5', 'gen_neg1_2', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_2_6', 'gen_neg1_2', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_2_7', 'gen_neg1_2', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_2_8', 'gen_neg1_2', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_2_9', 'gen_neg1_2', 'What is 17 - 8?', '9', '12', '6'),
('q_gen_neg1_2_10', 'gen_neg1_2', 'What is 12 + 14?', '26', '30', '22') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_3', 'Science', -1, 3, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_3_1', 'gen_neg1_3', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_3_2', 'gen_neg1_3', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_3_3', 'gen_neg1_3', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_3_4', 'gen_neg1_3', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_3_5', 'gen_neg1_3', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_3_6', 'gen_neg1_3', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_3_7', 'gen_neg1_3', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_3_8', 'gen_neg1_3', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_3_9', 'gen_neg1_3', 'What is 16 + 11?', '27', '31', '24'),
('q_gen_neg1_3_10', 'gen_neg1_3', 'What is 29 - 1?', '28', '29', '27') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_4', 'Science', -1, 4, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_4_1', 'gen_neg1_4', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_4_2', 'gen_neg1_4', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_4_3', 'gen_neg1_4', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_4_4', 'gen_neg1_4', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_4_5', 'gen_neg1_4', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_4_6', 'gen_neg1_4', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_4_7', 'gen_neg1_4', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_4_8', 'gen_neg1_4', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_4_9', 'gen_neg1_4', 'What is 17 + 11?', '28', '31', '23'),
('q_gen_neg1_4_10', 'gen_neg1_4', 'What is 5 + 11?', '16', '21', '13') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_5', 'Science', -1, 5, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_5_1', 'gen_neg1_5', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_5_2', 'gen_neg1_5', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_5_3', 'gen_neg1_5', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_5_4', 'gen_neg1_5', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_5_5', 'gen_neg1_5', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_5_6', 'gen_neg1_5', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_5_7', 'gen_neg1_5', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_5_8', 'gen_neg1_5', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_5_9', 'gen_neg1_5', 'What is 7 - 2?', '5', '7', '2'),
('q_gen_neg1_5_10', 'gen_neg1_5', 'What is 7 + 17?', '24', '27', '21') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_6', 'Science', -1, 6, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_6_1', 'gen_neg1_6', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_6_2', 'gen_neg1_6', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_6_3', 'gen_neg1_6', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_6_4', 'gen_neg1_6', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_6_5', 'gen_neg1_6', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_6_6', 'gen_neg1_6', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_6_7', 'gen_neg1_6', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_6_8', 'gen_neg1_6', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_6_9', 'gen_neg1_6', 'What is 12 + 20?', '32', '37', '30'),
('q_gen_neg1_6_10', 'gen_neg1_6', 'What is 33 - 29?', '4', '6', '2') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_7', 'Science', -1, 7, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_7_1', 'gen_neg1_7', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_7_2', 'gen_neg1_7', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_7_3', 'gen_neg1_7', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_7_4', 'gen_neg1_7', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_7_5', 'gen_neg1_7', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_7_6', 'gen_neg1_7', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_7_7', 'gen_neg1_7', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_7_8', 'gen_neg1_7', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_7_9', 'gen_neg1_7', 'What is 14 - 7?', '7', '10', '6'),
('q_gen_neg1_7_10', 'gen_neg1_7', 'What is 24 - 4?', '20', '22', '17') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_8', 'Science', -1, 8, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_8_1', 'gen_neg1_8', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_8_2', 'gen_neg1_8', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_8_3', 'gen_neg1_8', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_8_4', 'gen_neg1_8', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_8_5', 'gen_neg1_8', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_8_6', 'gen_neg1_8', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_8_7', 'gen_neg1_8', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_8_8', 'gen_neg1_8', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_8_9', 'gen_neg1_8', 'What is 7 + 8?', '15', '17', '10'),
('q_gen_neg1_8_10', 'gen_neg1_8', 'What is 6 + 17?', '23', '25', '21') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_9', 'Science', -1, 9, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_9_1', 'gen_neg1_9', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_9_2', 'gen_neg1_9', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_9_3', 'gen_neg1_9', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_9_4', 'gen_neg1_9', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_9_5', 'gen_neg1_9', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_9_6', 'gen_neg1_9', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_9_7', 'gen_neg1_9', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_9_8', 'gen_neg1_9', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_9_9', 'gen_neg1_9', 'What is 19 + 15?', '34', '35', '29'),
('q_gen_neg1_9_10', 'gen_neg1_9', 'What is 4 + 21?', '25', '26', '24') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_neg1_10', 'Science', -1, 10, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_neg1_10_1', 'gen_neg1_10', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_neg1_10_2', 'gen_neg1_10', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_neg1_10_3', 'gen_neg1_10', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_neg1_10_4', 'gen_neg1_10', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_neg1_10_5', 'gen_neg1_10', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_neg1_10_6', 'gen_neg1_10', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_neg1_10_7', 'gen_neg1_10', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_neg1_10_8', 'gen_neg1_10', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_neg1_10_9', 'gen_neg1_10', 'What is 24 - 12?', '12', '15', '9'),
('q_gen_neg1_10_10', 'gen_neg1_10', 'What is 15 + 18?', '33', '37', '31') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;

-- Kindergarten (Grade 0)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_1', 'Math', 0, 1, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_1_1', 'gen_0_1', 'What is 4 + 21?', '25', '29', '20'),
('q_gen_0_1_2', 'gen_0_1', 'What is 13 + 12?', '25', '28', '22'),
('q_gen_0_1_3', 'gen_0_1', 'What is 22 + 21?', '43', '44', '41'),
('q_gen_0_1_4', 'gen_0_1', 'What is 14 + 9?', '23', '28', '18'),
('q_gen_0_1_5', 'gen_0_1', 'What is 20 + 5?', '25', '27', '22'),
('q_gen_0_1_6', 'gen_0_1', 'What is 20 + 15?', '35', '37', '34'),
('q_gen_0_1_7', 'gen_0_1', 'What is 22 + 17?', '39', '41', '37'),
('q_gen_0_1_8', 'gen_0_1', 'What is 7 + 7?', '14', '17', '10'),
('q_gen_0_1_9', 'gen_0_1', 'What is 31 - 28?', '3', '6', '0'),
('q_gen_0_1_10', 'gen_0_1', 'What is 18 + 5?', '23', '24', '21') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_2', 'Math', 0, 2, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_2_1', 'gen_0_2', 'What is 1 + 18?', '19', '21', '17'),
('q_gen_0_2_2', 'gen_0_2', 'What is 24 - 5?', '19', '22', '18'),
('q_gen_0_2_3', 'gen_0_2', 'What is 16 + 2?', '18', '22', '15'),
('q_gen_0_2_4', 'gen_0_2', 'What is 20 + 17?', '37', '41', '33'),
('q_gen_0_2_5', 'gen_0_2', 'What is 18 + 2?', '20', '21', '17'),
('q_gen_0_2_6', 'gen_0_2', 'What is 23 - 15?', '8', '9', '5'),
('q_gen_0_2_7', 'gen_0_2', 'What is 9 + 20?', '29', '30', '24'),
('q_gen_0_2_8', 'gen_0_2', 'What is 16 + 1?', '17', '19', '15'),
('q_gen_0_2_9', 'gen_0_2', 'What is 21 + 23?', '44', '47', '39'),
('q_gen_0_2_10', 'gen_0_2', 'What is 19 - 7?', '12', '15', '11') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_3', 'Math', 0, 3, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_3_1', 'gen_0_3', 'What is 13 + 4?', '17', '19', '14'),
('q_gen_0_3_2', 'gen_0_3', 'What is 25 + 7?', '32', '36', '28'),
('q_gen_0_3_3', 'gen_0_3', 'What is 7 - 2?', '5', '7', '4'),
('q_gen_0_3_4', 'gen_0_3', 'What is 16 + 18?', '34', '37', '32'),
('q_gen_0_3_5', 'gen_0_3', 'What is 9 - 6?', '3', '4', '1'),
('q_gen_0_3_6', 'gen_0_3', 'What is 35 - 20?', '15', '18', '12'),
('q_gen_0_3_7', 'gen_0_3', 'What is 15 - 2?', '13', '14', '12'),
('q_gen_0_3_8', 'gen_0_3', 'What is 16 - 14?', '2', '3', '0'),
('q_gen_0_3_9', 'gen_0_3', 'What is 10 - 3?', '7', '8', '5'),
('q_gen_0_3_10', 'gen_0_3', 'What is 36 - 18?', '18', '19', '17') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_4', 'Math', 0, 4, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_4_1', 'gen_0_4', 'What is 36 - 20?', '16', '18', '15'),
('q_gen_0_4_2', 'gen_0_4', 'What is 4 + 12?', '16', '17', '12'),
('q_gen_0_4_3', 'gen_0_4', 'What is 22 + 8?', '30', '34', '26'),
('q_gen_0_4_4', 'gen_0_4', 'What is 21 + 22?', '43', '45', '40'),
('q_gen_0_4_5', 'gen_0_4', 'What is 16 - 5?', '11', '12', '8'),
('q_gen_0_4_6', 'gen_0_4', 'What is 15 + 25?', '40', '41', '36'),
('q_gen_0_4_7', 'gen_0_4', 'What is 14 - 5?', '9', '10', '7'),
('q_gen_0_4_8', 'gen_0_4', 'What is 18 + 24?', '42', '46', '37'),
('q_gen_0_4_9', 'gen_0_4', 'What is 2 + 18?', '20', '25', '18'),
('q_gen_0_4_10', 'gen_0_4', 'What is 9 + 19?', '28', '31', '23') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_5', 'Math', 0, 5, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_5_1', 'gen_0_5', 'What is 28 + 27?', '55', '60', '53'),
('q_gen_0_5_2', 'gen_0_5', 'What is 7 + 4?', '11', '12', '8'),
('q_gen_0_5_3', 'gen_0_5', 'What is 34 - 9?', '25', '27', '22'),
('q_gen_0_5_4', 'gen_0_5', 'What is 26 + 9?', '35', '38', '32'),
('q_gen_0_5_5', 'gen_0_5', 'What is 35 - 26?', '9', '11', '6'),
('q_gen_0_5_6', 'gen_0_5', 'What is 41 - 26?', '15', '18', '12'),
('q_gen_0_5_7', 'gen_0_5', 'What is 11 - 6?', '5', '6', '2'),
('q_gen_0_5_8', 'gen_0_5', 'What is 26 + 7?', '33', '37', '28'),
('q_gen_0_5_9', 'gen_0_5', 'What is 5 + 8?', '13', '14', '12'),
('q_gen_0_5_10', 'gen_0_5', 'What is 12 + 7?', '19', '24', '18') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_6', 'Science', 0, 6, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_6_1', 'gen_0_6', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_0_6_2', 'gen_0_6', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_0_6_3', 'gen_0_6', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_0_6_4', 'gen_0_6', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_0_6_5', 'gen_0_6', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_0_6_6', 'gen_0_6', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_0_6_7', 'gen_0_6', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_0_6_8', 'gen_0_6', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_0_6_9', 'gen_0_6', 'What is 20 + 30?', '50', '51', '49'),
('q_gen_0_6_10', 'gen_0_6', 'What is 9 + 23?', '32', '35', '27') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_7', 'Science', 0, 7, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_7_1', 'gen_0_7', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_0_7_2', 'gen_0_7', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_0_7_3', 'gen_0_7', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_0_7_4', 'gen_0_7', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_0_7_5', 'gen_0_7', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_0_7_6', 'gen_0_7', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_0_7_7', 'gen_0_7', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_0_7_8', 'gen_0_7', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_0_7_9', 'gen_0_7', 'What is 32 - 18?', '14', '16', '13'),
('q_gen_0_7_10', 'gen_0_7', 'What is 38 - 1?', '37', '39', '36') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_8', 'Science', 0, 8, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_8_1', 'gen_0_8', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_0_8_2', 'gen_0_8', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_0_8_3', 'gen_0_8', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_0_8_4', 'gen_0_8', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_0_8_5', 'gen_0_8', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_0_8_6', 'gen_0_8', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_0_8_7', 'gen_0_8', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_0_8_8', 'gen_0_8', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_0_8_9', 'gen_0_8', 'What is 4 + 32?', '36', '37', '32'),
('q_gen_0_8_10', 'gen_0_8', 'What is 16 - 12?', '4', '6', '2') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_9', 'Social Studies', 0, 9, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_9_1', 'gen_0_9', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_0_9_2', 'gen_0_9', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_0_9_3', 'gen_0_9', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_0_9_4', 'gen_0_9', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_0_9_5', 'gen_0_9', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_0_9_6', 'gen_0_9', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_0_9_7', 'gen_0_9', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_0_9_8', 'gen_0_9', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_0_9_9', 'gen_0_9', 'What is 20 - 3?', '17', '18', '16'),
('q_gen_0_9_10', 'gen_0_9', 'What is 39 - 11?', '28', '31', '27') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_0_10', 'Social Studies', 0, 10, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_0_10_1', 'gen_0_10', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_0_10_2', 'gen_0_10', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_0_10_3', 'gen_0_10', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_0_10_4', 'gen_0_10', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_0_10_5', 'gen_0_10', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_0_10_6', 'gen_0_10', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_0_10_7', 'gen_0_10', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_0_10_8', 'gen_0_10', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_0_10_9', 'gen_0_10', 'What is 37 - 32?', '5', '8', '3'),
('q_gen_0_10_10', 'gen_0_10', 'What is 23 - 19?', '4', '7', '1') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;

-- 1st Grade (Grade 1)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_1', 'Math', 1, 1, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_1_1', 'gen_1_1', 'What is 1 + 16?', '17', '19', '15'),
('q_gen_1_1_2', 'gen_1_1', 'What is 21 - 4?', '17', '20', '14'),
('q_gen_1_1_3', 'gen_1_1', 'What is 34 - 14?', '20', '21', '19'),
('q_gen_1_1_4', 'gen_1_1', 'What is 13 - 11?', '2', '5', '0'),
('q_gen_1_1_5', 'gen_1_1', 'What is 8 + 26?', '34', '38', '29'),
('q_gen_1_1_6', 'gen_1_1', 'What is 1 + 13?', '14', '16', '11'),
('q_gen_1_1_7', 'gen_1_1', 'What is 20 + 5?', '25', '29', '22'),
('q_gen_1_1_8', 'gen_1_1', 'What is 9 + 1?', '10', '11', '9'),
('q_gen_1_1_9', 'gen_1_1', 'What is 41 - 6?', '35', '37', '34'),
('q_gen_1_1_10', 'gen_1_1', 'What is 16 - 3?', '13', '14', '10') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_2', 'Math', 1, 2, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_2_1', 'gen_1_2', 'What is 13 + 6?', '19', '24', '16'),
('q_gen_1_2_2', 'gen_1_2', 'What is 33 - 12?', '21', '23', '18'),
('q_gen_1_2_3', 'gen_1_2', 'What is 4 + 9?', '13', '16', '8'),
('q_gen_1_2_4', 'gen_1_2', 'What is 16 - 11?', '5', '8', '3'),
('q_gen_1_2_5', 'gen_1_2', 'What is 17 + 15?', '32', '35', '29'),
('q_gen_1_2_6', 'gen_1_2', 'What is 2 + 9?', '11', '16', '6'),
('q_gen_1_2_7', 'gen_1_2', 'What is 8 + 29?', '37', '39', '34'),
('q_gen_1_2_8', 'gen_1_2', 'What is 35 - 18?', '17', '18', '15'),
('q_gen_1_2_9', 'gen_1_2', 'What is 16 + 13?', '29', '34', '28'),
('q_gen_1_2_10', 'gen_1_2', 'What is 30 + 19?', '49', '50', '44') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_3', 'Math', 1, 3, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_3_1', 'gen_1_3', 'What is 32 - 14?', '18', '20', '15'),
('q_gen_1_3_2', 'gen_1_3', 'What is 30 + 12?', '42', '44', '41'),
('q_gen_1_3_3', 'gen_1_3', 'What is 27 - 11?', '16', '19', '13'),
('q_gen_1_3_4', 'gen_1_3', 'What is 11 - 5?', '6', '9', '4'),
('q_gen_1_3_5', 'gen_1_3', 'What is 18 - 13?', '5', '6', '2'),
('q_gen_1_3_6', 'gen_1_3', 'What is 32 + 19?', '51', '56', '49'),
('q_gen_1_3_7', 'gen_1_3', 'What is 17 - 10?', '7', '8', '4'),
('q_gen_1_3_8', 'gen_1_3', 'What is 32 + 31?', '63', '64', '58'),
('q_gen_1_3_9', 'gen_1_3', 'What is 9 + 19?', '28', '33', '23'),
('q_gen_1_3_10', 'gen_1_3', 'What is 28 - 7?', '21', '23', '19') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_4', 'Math', 1, 4, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_4_1', 'gen_1_4', 'What is 19 + 12?', '31', '35', '29'),
('q_gen_1_4_2', 'gen_1_4', 'What is 30 - 30?', '0', '2', '1'),
('q_gen_1_4_3', 'gen_1_4', 'What is 35 - 30?', '5', '8', '4'),
('q_gen_1_4_4', 'gen_1_4', 'What is 3 + 19?', '22', '24', '19'),
('q_gen_1_4_5', 'gen_1_4', 'What is 30 + 35?', '65', '67', '64'),
('q_gen_1_4_6', 'gen_1_4', 'What is 35 - 4?', '31', '32', '29'),
('q_gen_1_4_7', 'gen_1_4', 'What is 32 - 1?', '31', '34', '30'),
('q_gen_1_4_8', 'gen_1_4', 'What is 39 - 31?', '8', '11', '6'),
('q_gen_1_4_9', 'gen_1_4', 'What is 30 + 30?', '60', '61', '55'),
('q_gen_1_4_10', 'gen_1_4', 'What is 27 + 37?', '64', '66', '63') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_5', 'Math', 1, 5, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_5_1', 'gen_1_5', 'What is 39 + 23?', '62', '64', '59'),
('q_gen_1_5_2', 'gen_1_5', 'What is 12 - 1?', '11', '14', '9'),
('q_gen_1_5_3', 'gen_1_5', 'What is 29 - 28?', '1', '3', '2'),
('q_gen_1_5_4', 'gen_1_5', 'What is 29 - 14?', '15', '17', '12'),
('q_gen_1_5_5', 'gen_1_5', 'What is 7 - 7?', '0', '1', '2'),
('q_gen_1_5_6', 'gen_1_5', 'What is 18 + 39?', '57', '59', '53'),
('q_gen_1_5_7', 'gen_1_5', 'What is 32 + 8?', '40', '41', '35'),
('q_gen_1_5_8', 'gen_1_5', 'What is 3 + 12?', '15', '20', '14'),
('q_gen_1_5_9', 'gen_1_5', 'What is 5 + 15?', '20', '23', '18'),
('q_gen_1_5_10', 'gen_1_5', 'What is 34 - 33?', '1', '3', '2') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_6', 'Science', 1, 6, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_6_1', 'gen_1_6', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_1_6_2', 'gen_1_6', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_1_6_3', 'gen_1_6', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_1_6_4', 'gen_1_6', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_1_6_5', 'gen_1_6', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_1_6_6', 'gen_1_6', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_1_6_7', 'gen_1_6', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_1_6_8', 'gen_1_6', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_1_6_9', 'gen_1_6', 'What is 13 + 24?', '37', '42', '34'),
('q_gen_1_6_10', 'gen_1_6', 'What is 27 + 33?', '60', '63', '56') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_7', 'Science', 1, 7, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_7_1', 'gen_1_7', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_1_7_2', 'gen_1_7', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_1_7_3', 'gen_1_7', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_1_7_4', 'gen_1_7', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_1_7_5', 'gen_1_7', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_1_7_6', 'gen_1_7', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_1_7_7', 'gen_1_7', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_1_7_8', 'gen_1_7', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_1_7_9', 'gen_1_7', 'What is 5 + 17?', '22', '25', '19'),
('q_gen_1_7_10', 'gen_1_7', 'What is 26 + 34?', '60', '62', '56') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_8', 'Science', 1, 8, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_8_1', 'gen_1_8', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_1_8_2', 'gen_1_8', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_1_8_3', 'gen_1_8', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_1_8_4', 'gen_1_8', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_1_8_5', 'gen_1_8', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_1_8_6', 'gen_1_8', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_1_8_7', 'gen_1_8', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_1_8_8', 'gen_1_8', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_1_8_9', 'gen_1_8', 'What is 6 - 6?', '0', '1', '2'),
('q_gen_1_8_10', 'gen_1_8', 'What is 26 + 6?', '32', '33', '30') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_9', 'Social Studies', 1, 9, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_9_1', 'gen_1_9', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_1_9_2', 'gen_1_9', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_1_9_3', 'gen_1_9', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_1_9_4', 'gen_1_9', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_1_9_5', 'gen_1_9', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_1_9_6', 'gen_1_9', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_1_9_7', 'gen_1_9', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_1_9_8', 'gen_1_9', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_1_9_9', 'gen_1_9', 'What is 8 + 29?', '37', '38', '36'),
('q_gen_1_9_10', 'gen_1_9', 'What is 39 - 35?', '4', '5', '1') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_1_10', 'Social Studies', 1, 10, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_1_10_1', 'gen_1_10', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_1_10_2', 'gen_1_10', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_1_10_3', 'gen_1_10', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_1_10_4', 'gen_1_10', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_1_10_5', 'gen_1_10', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_1_10_6', 'gen_1_10', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_1_10_7', 'gen_1_10', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_1_10_8', 'gen_1_10', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_1_10_9', 'gen_1_10', 'What is 11 - 11?', '0', '2', '3'),
('q_gen_1_10_10', 'gen_1_10', 'What is 31 - 21?', '10', '11', '9') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;

-- 2nd Grade (Grade 2)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_1', 'Math', 2, 1, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_1_1', 'gen_2_1', 'What is 10 + 26?', '36', '39', '33'),
('q_gen_2_1_2', 'gen_2_1', 'What is 4 x 5?', '20', '24', '15'),
('q_gen_2_1_3', 'gen_2_1', 'What is 10 + 6?', '16', '20', '14'),
('q_gen_2_1_4', 'gen_2_1', 'What is 2 x 7?', '14', '16', '7'),
('q_gen_2_1_5', 'gen_2_1', 'What is 8 - 5?', '3', '4', '2'),
('q_gen_2_1_6', 'gen_2_1', 'What is 24 + 18?', '42', '43', '37'),
('q_gen_2_1_7', 'gen_2_1', 'What is 8 - 2?', '6', '9', '3'),
('q_gen_2_1_8', 'gen_2_1', 'What is 16 + 20?', '36', '39', '31'),
('q_gen_2_1_9', 'gen_2_1', 'What is 37 - 9?', '28', '30', '25'),
('q_gen_2_1_10', 'gen_2_1', 'What is 15 - 14?', '1', '2', '8') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_2', 'Math', 2, 2, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_2_1', 'gen_2_2', 'What is 5 x 1?', '5', '10', '4'),
('q_gen_2_2_2', 'gen_2_2', 'What is 14 + 21?', '35', '39', '31'),
('q_gen_2_2_3', 'gen_2_2', 'What is 31 + 8?', '39', '41', '34'),
('q_gen_2_2_4', 'gen_2_2', 'What is 38 + 20?', '58', '62', '57'),
('q_gen_2_2_5', 'gen_2_2', 'What is 16 + 12?', '28', '30', '27'),
('q_gen_2_2_6', 'gen_2_2', 'What is 17 + 17?', '34', '38', '31'),
('q_gen_2_2_7', 'gen_2_2', 'What is 4 x 2?', '8', '12', '6'),
('q_gen_2_2_8', 'gen_2_2', 'What is 17 + 35?', '52', '55', '47'),
('q_gen_2_2_9', 'gen_2_2', 'What is 10 - 1?', '9', '10', '7'),
('q_gen_2_2_10', 'gen_2_2', 'What is 34 + 12?', '46', '51', '42') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_3', 'Math', 2, 3, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_3_1', 'gen_2_3', 'What is 36 + 32?', '68', '72', '67'),
('q_gen_2_3_2', 'gen_2_3', 'What is 2 x 7?', '14', '16', '7'),
('q_gen_2_3_3', 'gen_2_3', 'What is 31 + 1?', '32', '36', '29'),
('q_gen_2_3_4', 'gen_2_3', 'What is 14 - 7?', '7', '8', '5'),
('q_gen_2_3_5', 'gen_2_3', 'What is 7 x 4?', '28', '35', '24'),
('q_gen_2_3_6', 'gen_2_3', 'What is 1 x 1?', '1', '2', '0'),
('q_gen_2_3_7', 'gen_2_3', 'What is 3 x 7?', '21', '24', '14'),
('q_gen_2_3_8', 'gen_2_3', 'What is 9 - 1?', '8', '9', '6'),
('q_gen_2_3_9', 'gen_2_3', 'What is 14 + 30?', '44', '46', '43'),
('q_gen_2_3_10', 'gen_2_3', 'What is 29 - 13?', '16', '17', '15') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_4', 'Math', 2, 4, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_4_1', 'gen_2_4', 'What is 50 - 24?', '26', '28', '24'),
('q_gen_2_4_2', 'gen_2_4', 'What is 37 - 4?', '33', '34', '31'),
('q_gen_2_4_3', 'gen_2_4', 'What is 43 - 6?', '37', '39', '34'),
('q_gen_2_4_4', 'gen_2_4', 'What is 3 x 2?', '6', '9', '4'),
('q_gen_2_4_5', 'gen_2_4', 'What is 7 x 0?', '0', '7', '8'),
('q_gen_2_4_6', 'gen_2_4', 'What is 44 + 43?', '87', '92', '85'),
('q_gen_2_4_7', 'gen_2_4', 'What is 43 + 44?', '87', '89', '83'),
('q_gen_2_4_8', 'gen_2_4', 'What is 7 x 2?', '14', '21', '12'),
('q_gen_2_4_9', 'gen_2_4', 'What is 8 x 5?', '40', '48', '35'),
('q_gen_2_4_10', 'gen_2_4', 'What is 5 x 4?', '20', '25', '16') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_5', 'Math', 2, 5, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_5_1', 'gen_2_5', 'What is 7 + 4?', '11', '15', '6'),
('q_gen_2_5_2', 'gen_2_5', 'What is 5 x 0?', '0', '5', '7'),
('q_gen_2_5_3', 'gen_2_5', 'What is 3 x 1?', '3', '6', '2'),
('q_gen_2_5_4', 'gen_2_5', 'What is 12 - 1?', '11', '14', '8'),
('q_gen_2_5_5', 'gen_2_5', 'What is 8 x 7?', '56', '64', '49'),
('q_gen_2_5_6', 'gen_2_5', 'What is 41 + 26?', '67', '72', '65'),
('q_gen_2_5_7', 'gen_2_5', 'What is 4 x 1?', '4', '8', '3'),
('q_gen_2_5_8', 'gen_2_5', 'What is 6 - 4?', '2', '3', '0'),
('q_gen_2_5_9', 'gen_2_5', 'What is 3 x 7?', '21', '24', '14'),
('q_gen_2_5_10', 'gen_2_5', 'What is 6 x 7?', '42', '48', '35') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_6', 'Science', 2, 6, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_6_1', 'gen_2_6', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_2_6_2', 'gen_2_6', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_2_6_3', 'gen_2_6', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_2_6_4', 'gen_2_6', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_2_6_5', 'gen_2_6', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_2_6_6', 'gen_2_6', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_2_6_7', 'gen_2_6', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_2_6_8', 'gen_2_6', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_2_6_9', 'gen_2_6', 'What is 51 - 27?', '24', '26', '23'),
('q_gen_2_6_10', 'gen_2_6', 'What is 6 x 5?', '30', '36', '25') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_7', 'Science', 2, 7, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_7_1', 'gen_2_7', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_2_7_2', 'gen_2_7', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_2_7_3', 'gen_2_7', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_2_7_4', 'gen_2_7', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_2_7_5', 'gen_2_7', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_2_7_6', 'gen_2_7', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_2_7_7', 'gen_2_7', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_2_7_8', 'gen_2_7', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_2_7_9', 'gen_2_7', 'What is 3 x 6?', '18', '21', '12'),
('q_gen_2_7_10', 'gen_2_7', 'What is 44 + 47?', '91', '96', '89') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_8', 'Science', 2, 8, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_8_1', 'gen_2_8', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_2_8_2', 'gen_2_8', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_2_8_3', 'gen_2_8', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_2_8_4', 'gen_2_8', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_2_8_5', 'gen_2_8', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_2_8_6', 'gen_2_8', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_2_8_7', 'gen_2_8', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_2_8_8', 'gen_2_8', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_2_8_9', 'gen_2_8', 'What is 40 - 25?', '15', '18', '12'),
('q_gen_2_8_10', 'gen_2_8', 'What is 29 + 34?', '63', '65', '58') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_9', 'Social Studies', 2, 9, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_9_1', 'gen_2_9', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_2_9_2', 'gen_2_9', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_2_9_3', 'gen_2_9', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_2_9_4', 'gen_2_9', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_2_9_5', 'gen_2_9', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_2_9_6', 'gen_2_9', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_2_9_7', 'gen_2_9', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_2_9_8', 'gen_2_9', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_2_9_9', 'gen_2_9', 'What is 45 - 31?', '14', '16', '13'),
('q_gen_2_9_10', 'gen_2_9', 'What is 7 x 2?', '14', '21', '12') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_2_10', 'Social Studies', 2, 10, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_2_10_1', 'gen_2_10', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_2_10_2', 'gen_2_10', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_2_10_3', 'gen_2_10', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_2_10_4', 'gen_2_10', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_2_10_5', 'gen_2_10', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_2_10_6', 'gen_2_10', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_2_10_7', 'gen_2_10', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_2_10_8', 'gen_2_10', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_2_10_9', 'gen_2_10', 'What is 33 - 19?', '14', '16', '11'),
('q_gen_2_10_10', 'gen_2_10', 'What is 13 - 7?', '6', '8', '5') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;

-- 3rd Grade (Grade 3)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_1', 'Math', 3, 1, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_1_1', 'gen_3_1', 'What is 22 + 40?', '62', '65', '61'),
('q_gen_3_1_2', 'gen_3_1', 'What is 7 + 27?', '34', '39', '33'),
('q_gen_3_1_3', 'gen_3_1', 'What is 7 x 4?', '28', '35', '24'),
('q_gen_3_1_4', 'gen_3_1', 'What is 26 + 22?', '48', '51', '47'),
('q_gen_3_1_5', 'gen_3_1', 'What is 21 + 1?', '22', '24', '20'),
('q_gen_3_1_6', 'gen_3_1', 'What is 37 - 36?', '1', '2', '0'),
('q_gen_3_1_7', 'gen_3_1', 'What is 7 x 1?', '7', '14', '6'),
('q_gen_3_1_8', 'gen_3_1', 'What is 4 + 21?', '25', '30', '24'),
('q_gen_3_1_9', 'gen_3_1', 'What is 15 + 31?', '46', '50', '42'),
('q_gen_3_1_10', 'gen_3_1', 'What is 2 x 6?', '12', '14', '6') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_2', 'Math', 3, 2, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_2_1', 'gen_3_2', 'What is 43 + 41?', '84', '88', '83'),
('q_gen_3_2_2', 'gen_3_2', 'What is 18 + 14?', '32', '36', '30'),
('q_gen_3_2_3', 'gen_3_2', 'What is 43 + 9?', '52', '56', '47'),
('q_gen_3_2_4', 'gen_3_2', 'What is 8 x 0?', '0', '8', '7'),
('q_gen_3_2_5', 'gen_3_2', 'What is 11 + 1?', '12', '15', '8'),
('q_gen_3_2_6', 'gen_3_2', 'What is 22 + 37?', '59', '60', '58'),
('q_gen_3_2_7', 'gen_3_2', 'What is 45 + 31?', '76', '80', '75'),
('q_gen_3_2_8', 'gen_3_2', 'What is 39 - 28?', '11', '14', '10'),
('q_gen_3_2_9', 'gen_3_2', 'What is 48 - 47?', '1', '4', '8'),
('q_gen_3_2_10', 'gen_3_2', 'What is 1 x 4?', '4', '5', '0') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_3', 'Math', 3, 3, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_3_1', 'gen_3_3', 'What is 23 + 36?', '59', '62', '57'),
('q_gen_3_3_2', 'gen_3_3', 'What is 32 - 7?', '25', '28', '24'),
('q_gen_3_3_3', 'gen_3_3', 'What is 30 - 30?', '0', '1', '2'),
('q_gen_3_3_4', 'gen_3_3', 'What is 31 + 16?', '47', '48', '44'),
('q_gen_3_3_5', 'gen_3_3', 'What is 31 + 30?', '61', '64', '58'),
('q_gen_3_3_6', 'gen_3_3', 'What is 3 x 2?', '6', '9', '4'),
('q_gen_3_3_7', 'gen_3_3', 'What is 1 x 4?', '4', '5', '0'),
('q_gen_3_3_8', 'gen_3_3', 'What is 8 + 24?', '32', '35', '29'),
('q_gen_3_3_9', 'gen_3_3', 'What is 8 x 3?', '24', '32', '21'),
('q_gen_3_3_10', 'gen_3_3', 'What is 35 - 29?', '6', '7', '3') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_4', 'Math', 3, 4, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_4_1', 'gen_3_4', 'What is 43 - 7?', '36', '39', '34'),
('q_gen_3_4_2', 'gen_3_4', 'What is 42 + 52?', '94', '98', '89'),
('q_gen_3_4_3', 'gen_3_4', 'What is 3 x 8?', '24', '27', '16'),
('q_gen_3_4_4', 'gen_3_4', 'What is 28 - 9?', '19', '20', '17'),
('q_gen_3_4_5', 'gen_3_4', 'What is 7 x 5?', '35', '42', '30'),
('q_gen_3_4_6', 'gen_3_4', 'What is 33 + 31?', '64', '66', '61'),
('q_gen_3_4_7', 'gen_3_4', 'What is 43 - 17?', '26', '27', '24'),
('q_gen_3_4_8', 'gen_3_4', 'What is 7 x 2?', '14', '21', '12'),
('q_gen_3_4_9', 'gen_3_4', 'What is 2 + 43?', '45', '49', '42'),
('q_gen_3_4_10', 'gen_3_4', 'What is 15 - 8?', '7', '10', '5') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_5', 'Math', 3, 5, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_5_1', 'gen_3_5', 'What is 70 - 58?', '12', '13', '9'),
('q_gen_3_5_2', 'gen_3_5', 'What is 1 x 5?', '5', '6', '0'),
('q_gen_3_5_3', 'gen_3_5', 'What is 68 - 66?', '2', '5', '1'),
('q_gen_3_5_4', 'gen_3_5', 'What is 34 + 6?', '40', '42', '35'),
('q_gen_3_5_5', 'gen_3_5', 'What is 11 + 44?', '55', '57', '53'),
('q_gen_3_5_6', 'gen_3_5', 'What is 29 + 52?', '81', '86', '79'),
('q_gen_3_5_7', 'gen_3_5', 'What is 5 x 2?', '10', '15', '8'),
('q_gen_3_5_8', 'gen_3_5', 'What is 57 + 3?', '60', '65', '57'),
('q_gen_3_5_9', 'gen_3_5', 'What is 57 - 36?', '21', '22', '19'),
('q_gen_3_5_10', 'gen_3_5', 'What is 36 - 24?', '12', '13', '9') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_6', 'Science', 3, 6, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_6_1', 'gen_3_6', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_3_6_2', 'gen_3_6', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_3_6_3', 'gen_3_6', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_3_6_4', 'gen_3_6', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_3_6_5', 'gen_3_6', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_3_6_6', 'gen_3_6', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_3_6_7', 'gen_3_6', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_3_6_8', 'gen_3_6', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_3_6_9', 'gen_3_6', 'What is 69 - 47?', '22', '23', '20'),
('q_gen_3_6_10', 'gen_3_6', 'What is 7 x 7?', '49', '56', '42') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_7', 'Science', 3, 7, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_7_1', 'gen_3_7', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_3_7_2', 'gen_3_7', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_3_7_3', 'gen_3_7', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_3_7_4', 'gen_3_7', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_3_7_5', 'gen_3_7', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_3_7_6', 'gen_3_7', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_3_7_7', 'gen_3_7', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_3_7_8', 'gen_3_7', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_3_7_9', 'gen_3_7', 'What is 61 - 15?', '46', '47', '43'),
('q_gen_3_7_10', 'gen_3_7', 'What is 9 x 7?', '63', '72', '56') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_8', 'Science', 3, 8, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_8_1', 'gen_3_8', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_3_8_2', 'gen_3_8', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_3_8_3', 'gen_3_8', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_3_8_4', 'gen_3_8', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_3_8_5', 'gen_3_8', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_3_8_6', 'gen_3_8', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_3_8_7', 'gen_3_8', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_3_8_8', 'gen_3_8', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_3_8_9', 'gen_3_8', 'What is 9 x 5?', '45', '54', '40'),
('q_gen_3_8_10', 'gen_3_8', 'What is 73 + 23?', '96', '97', '94') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_9', 'Social Studies', 3, 9, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_9_1', 'gen_3_9', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_3_9_2', 'gen_3_9', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_3_9_3', 'gen_3_9', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_3_9_4', 'gen_3_9', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_3_9_5', 'gen_3_9', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_3_9_6', 'gen_3_9', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_3_9_7', 'gen_3_9', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_3_9_8', 'gen_3_9', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_3_9_9', 'gen_3_9', 'What is 31 - 3?', '28', '31', '25'),
('q_gen_3_9_10', 'gen_3_9', 'What is 32 - 29?', '3', '4', '2') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_3_10', 'Social Studies', 3, 10, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_3_10_1', 'gen_3_10', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_3_10_2', 'gen_3_10', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_3_10_3', 'gen_3_10', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_3_10_4', 'gen_3_10', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_3_10_5', 'gen_3_10', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_3_10_6', 'gen_3_10', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_3_10_7', 'gen_3_10', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_3_10_8', 'gen_3_10', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_3_10_9', 'gen_3_10', 'What is 52 - 12?', '40', '42', '39'),
('q_gen_3_10_10', 'gen_3_10', 'What is 9 x 5?', '45', '54', '40') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;

-- 4th Grade (Grade 4)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_1', 'Math', 4, 1, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_1_1', 'gen_4_1', 'What is 8 x 8?', '64', '72', '56'),
('q_gen_4_1_2', 'gen_4_1', 'What is 45 + 13?', '58', '63', '54'),
('q_gen_4_1_3', 'gen_4_1', 'What is 18 - 17?', '1', '4', '2'),
('q_gen_4_1_4', 'gen_4_1', 'What is 6 / 2?', '3', '4', '2'),
('q_gen_4_1_5', 'gen_4_1', 'What is 27 - 27?', '0', '2', '1'),
('q_gen_4_1_6', 'gen_4_1', 'What is 1 x 8?', '8', '9', '0'),
('q_gen_4_1_7', 'gen_4_1', 'What is 34 + 28?', '62', '66', '60'),
('q_gen_4_1_8', 'gen_4_1', 'What is 38 - 37?', '1', '4', '0'),
('q_gen_4_1_9', 'gen_4_1', 'What is 52 - 12?', '40', '41', '38'),
('q_gen_4_1_10', 'gen_4_1', 'What is 43 - 9?', '34', '37', '32') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_2', 'Math', 4, 2, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_2_1', 'gen_4_2', 'What is 5 x 8?', '40', '45', '32'),
('q_gen_4_2_2', 'gen_4_2', 'What is 62 - 28?', '34', '35', '33'),
('q_gen_4_2_3', 'gen_4_2', 'What is 45 / 9?', '5', '6', '4'),
('q_gen_4_2_4', 'gen_4_2', 'What is 4 + 16?', '20', '21', '17'),
('q_gen_4_2_5', 'gen_4_2', 'What is 2 x 7?', '14', '16', '7'),
('q_gen_4_2_6', 'gen_4_2', 'What is 6 x 1?', '6', '12', '5'),
('q_gen_4_2_7', 'gen_4_2', 'What is 31 - 12?', '19', '20', '17'),
('q_gen_4_2_8', 'gen_4_2', 'What is 55 - 1?', '54', '55', '52'),
('q_gen_4_2_9', 'gen_4_2', 'What is 3 x 2?', '6', '9', '4'),
('q_gen_4_2_10', 'gen_4_2', 'What is 35 / 5?', '7', '8', '6') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_3', 'Math', 4, 3, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_3_1', 'gen_4_3', 'What is 8 x 0?', '0', '8', '7'),
('q_gen_4_3_2', 'gen_4_3', 'What is 2 x 0?', '0', '2', '7'),
('q_gen_4_3_3', 'gen_4_3', 'What is 7 - 2?', '5', '7', '3'),
('q_gen_4_3_4', 'gen_4_3', 'What is 35 / 5?', '7', '8', '6'),
('q_gen_4_3_5', 'gen_4_3', 'What is 5 x 8?', '40', '45', '32'),
('q_gen_4_3_6', 'gen_4_3', 'What is 42 - 6?', '36', '38', '35'),
('q_gen_4_3_7', 'gen_4_3', 'What is 21 + 47?', '68', '73', '67'),
('q_gen_4_3_8', 'gen_4_3', 'What is 56 - 45?', '11', '12', '9'),
('q_gen_4_3_9', 'gen_4_3', 'What is 20 / 10?', '2', '3', '1'),
('q_gen_4_3_10', 'gen_4_3', 'What is 2 x 1?', '2', '4', '1') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_4', 'Math', 4, 4, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_4_1', 'gen_4_4', 'What is 27 - 12?', '15', '17', '12'),
('q_gen_4_4_2', 'gen_4_4', 'What is 26 - 2?', '24', '25', '22'),
('q_gen_4_4_3', 'gen_4_4', 'What is 49 + 60?', '109', '112', '105'),
('q_gen_4_4_4', 'gen_4_4', 'What is 56 + 45?', '101', '104', '97'),
('q_gen_4_4_5', 'gen_4_4', 'What is 19 + 43?', '62', '63', '61'),
('q_gen_4_4_6', 'gen_4_4', 'What is 1 x 2?', '2', '3', '0'),
('q_gen_4_4_7', 'gen_4_4', 'What is 27 / 3?', '9', '10', '8'),
('q_gen_4_4_8', 'gen_4_4', 'What is 12 - 3?', '9', '12', '7'),
('q_gen_4_4_9', 'gen_4_4', 'What is 17 + 12?', '29', '30', '25'),
('q_gen_4_4_10', 'gen_4_4', 'What is 47 + 37?', '84', '86', '80') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_5', 'Math', 4, 5, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_5_1', 'gen_4_5', 'What is 7 x 5?', '35', '42', '30'),
('q_gen_4_5_2', 'gen_4_5', 'What is 9 x 6?', '54', '63', '48'),
('q_gen_4_5_3', 'gen_4_5', 'What is 6 x 7?', '42', '48', '35'),
('q_gen_4_5_4', 'gen_4_5', 'What is 10 x 4?', '40', '50', '36'),
('q_gen_4_5_5', 'gen_4_5', 'What is 15 / 5?', '3', '4', '2'),
('q_gen_4_5_6', 'gen_4_5', 'What is 84 / 6?', '14', '15', '13'),
('q_gen_4_5_7', 'gen_4_5', 'What is 3 x 1?', '3', '6', '2'),
('q_gen_4_5_8', 'gen_4_5', 'What is 51 + 9?', '60', '63', '55'),
('q_gen_4_5_9', 'gen_4_5', 'What is 34 + 42?', '76', '78', '72'),
('q_gen_4_5_10', 'gen_4_5', 'What is 4 + 13?', '17', '21', '13') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_6', 'Science', 4, 6, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_6_1', 'gen_4_6', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_4_6_2', 'gen_4_6', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_4_6_3', 'gen_4_6', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_4_6_4', 'gen_4_6', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_4_6_5', 'gen_4_6', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_4_6_6', 'gen_4_6', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_4_6_7', 'gen_4_6', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_4_6_8', 'gen_4_6', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_4_6_9', 'gen_4_6', 'What is 15 / 3?', '5', '6', '4'),
('q_gen_4_6_10', 'gen_4_6', 'What is 32 + 71?', '103', '108', '98') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_7', 'Science', 4, 7, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_7_1', 'gen_4_7', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_4_7_2', 'gen_4_7', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_4_7_3', 'gen_4_7', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_4_7_4', 'gen_4_7', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_4_7_5', 'gen_4_7', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_4_7_6', 'gen_4_7', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_4_7_7', 'gen_4_7', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_4_7_8', 'gen_4_7', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_4_7_9', 'gen_4_7', 'What is 63 + 70?', '133', '137', '131'),
('q_gen_4_7_10', 'gen_4_7', 'What is 8 + 42?', '50', '51', '47') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_8', 'Science', 4, 8, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_8_1', 'gen_4_8', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_4_8_2', 'gen_4_8', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_4_8_3', 'gen_4_8', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_4_8_4', 'gen_4_8', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_4_8_5', 'gen_4_8', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_4_8_6', 'gen_4_8', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_4_8_7', 'gen_4_8', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_4_8_8', 'gen_4_8', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_4_8_9', 'gen_4_8', 'What is 11 x 2?', '22', '33', '20'),
('q_gen_4_8_10', 'gen_4_8', 'What is 12 x 7?', '84', '96', '77') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_9', 'Social Studies', 4, 9, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_9_1', 'gen_4_9', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_4_9_2', 'gen_4_9', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_4_9_3', 'gen_4_9', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_4_9_4', 'gen_4_9', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_4_9_5', 'gen_4_9', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_4_9_6', 'gen_4_9', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_4_9_7', 'gen_4_9', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_4_9_8', 'gen_4_9', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_4_9_9', 'gen_4_9', 'What is 49 - 23?', '26', '28', '25'),
('q_gen_4_9_10', 'gen_4_9', 'What is 89 - 16?', '73', '75', '72') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_4_10', 'Social Studies', 4, 10, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_4_10_1', 'gen_4_10', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_4_10_2', 'gen_4_10', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_4_10_3', 'gen_4_10', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_4_10_4', 'gen_4_10', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_4_10_5', 'gen_4_10', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_4_10_6', 'gen_4_10', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_4_10_7', 'gen_4_10', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_4_10_8', 'gen_4_10', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_4_10_9', 'gen_4_10', 'What is 8 x 1?', '8', '16', '7'),
('q_gen_4_10_10', 'gen_4_10', 'What is 24 / 2?', '12', '13', '11') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;

-- 5th Grade (Grade 5)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_1', 'Math', 5, 1, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_1_1', 'gen_5_1', 'What is 5 + 4?', '9', '12', '8'),
('q_gen_5_1_2', 'gen_5_1', 'What is 40 / 4?', '10', '11', '9'),
('q_gen_5_1_3', 'gen_5_1', 'What is 5 x 8?', '40', '45', '32'),
('q_gen_5_1_4', 'gen_5_1', 'What is 1 x 9?', '9', '10', '0'),
('q_gen_5_1_5', 'gen_5_1', 'What is 2 x 4?', '8', '10', '4'),
('q_gen_5_1_6', 'gen_5_1', 'What is 10 x 7?', '70', '80', '63'),
('q_gen_5_1_7', 'gen_5_1', 'What is 60 / 4?', '15', '16', '14'),
('q_gen_5_1_8', 'gen_5_1', 'What is 60 - 58?', '2', '5', '0'),
('q_gen_5_1_9', 'gen_5_1', 'What is 30 + 39?', '69', '72', '67'),
('q_gen_5_1_10', 'gen_5_1', 'What is 72 / 8?', '9', '10', '8') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_2', 'Math', 5, 2, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_2_1', 'gen_5_2', 'What is 48 - 36?', '12', '13', '10'),
('q_gen_5_2_2', 'gen_5_2', 'What is 54 / 6?', '9', '10', '8'),
('q_gen_5_2_3', 'gen_5_2', 'What is 10 x 6?', '60', '70', '54'),
('q_gen_5_2_4', 'gen_5_2', 'What is 10 x 3?', '30', '40', '27'),
('q_gen_5_2_5', 'gen_5_2', 'What is 27 / 9?', '3', '4', '2'),
('q_gen_5_2_6', 'gen_5_2', 'What is 41 + 53?', '94', '96', '91'),
('q_gen_5_2_7', 'gen_5_2', 'What is 61 - 14?', '47', '49', '44'),
('q_gen_5_2_8', 'gen_5_2', 'What is 2 x 9?', '18', '20', '9'),
('q_gen_5_2_9', 'gen_5_2', 'What is 40 + 52?', '92', '95', '91'),
('q_gen_5_2_10', 'gen_5_2', 'What is 5 - 1?', '4', '6', '3') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_3', 'Math', 5, 3, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_3_1', 'gen_5_3', 'What is 36 / 4?', '9', '10', '8'),
('q_gen_5_3_2', 'gen_5_3', 'What is 1 x 9?', '9', '10', '0'),
('q_gen_5_3_3', 'gen_5_3', 'What is 15 - 8?', '7', '10', '5'),
('q_gen_5_3_4', 'gen_5_3', 'What is 50 - 29?', '21', '23', '20'),
('q_gen_5_3_5', 'gen_5_3', 'What is 1 x 10?', '10', '11', '0'),
('q_gen_5_3_6', 'gen_5_3', 'What is 5 x 1?', '5', '10', '4'),
('q_gen_5_3_7', 'gen_5_3', 'What is 32 / 8?', '4', '5', '3'),
('q_gen_5_3_8', 'gen_5_3', 'What is 18 / 2?', '9', '10', '8'),
('q_gen_5_3_9', 'gen_5_3', 'What is 140 / 10?', '14', '15', '13'),
('q_gen_5_3_10', 'gen_5_3', 'What is 58 + 17?', '75', '76', '74') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_4', 'Math', 5, 4, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_4_1', 'gen_5_4', 'What is 47 - 27?', '20', '21', '18'),
('q_gen_5_4_2', 'gen_5_4', 'What is 2 / 2?', '1', '2', '3'),
('q_gen_5_4_3', 'gen_5_4', 'What is 2 x 8?', '16', '18', '8'),
('q_gen_5_4_4', 'gen_5_4', 'What is 73 - 27?', '46', '49', '45'),
('q_gen_5_4_5', 'gen_5_4', 'What is 5 + 49?', '54', '56', '53'),
('q_gen_5_4_6', 'gen_5_4', 'What is 3 x 9?', '27', '30', '18'),
('q_gen_5_4_7', 'gen_5_4', 'What is 24 / 6?', '4', '5', '3'),
('q_gen_5_4_8', 'gen_5_4', 'What is 40 / 8?', '5', '6', '4'),
('q_gen_5_4_9', 'gen_5_4', 'What is 71 - 63?', '8', '10', '6'),
('q_gen_5_4_10', 'gen_5_4', 'What is 10 x 3?', '30', '40', '27') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_5', 'Math', 5, 5, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_5_1', 'gen_5_5', 'What is 8 x 1?', '8', '16', '7'),
('q_gen_5_5_2', 'gen_5_5', 'What is 12 x 2?', '24', '36', '22'),
('q_gen_5_5_3', 'gen_5_5', 'What is 50 / 5?', '10', '11', '9'),
('q_gen_5_5_4', 'gen_5_5', 'What is 61 + 3?', '64', '68', '59'),
('q_gen_5_5_5', 'gen_5_5', 'What is 54 + 67?', '121', '122', '116'),
('q_gen_5_5_6', 'gen_5_5', 'What is 8 x 0?', '0', '8', '7'),
('q_gen_5_5_7', 'gen_5_5', 'What is 90 / 10?', '9', '10', '8'),
('q_gen_5_5_8', 'gen_5_5', 'What is 84 / 7?', '12', '13', '11'),
('q_gen_5_5_9', 'gen_5_5', 'What is 64 - 20?', '44', '47', '41'),
('q_gen_5_5_10', 'gen_5_5', 'What is 67 + 67?', '134', '138', '132') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_6', 'Science', 5, 6, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_6_1', 'gen_5_6', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_5_6_2', 'gen_5_6', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_5_6_3', 'gen_5_6', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_5_6_4', 'gen_5_6', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_5_6_5', 'gen_5_6', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_5_6_6', 'gen_5_6', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_5_6_7', 'gen_5_6', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_5_6_8', 'gen_5_6', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_5_6_9', 'gen_5_6', 'What is 60 / 10?', '6', '7', '5'),
('q_gen_5_6_10', 'gen_5_6', 'What is 12 x 10?', '120', '132', '110') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_7', 'Science', 5, 7, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_7_1', 'gen_5_7', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_5_7_2', 'gen_5_7', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_5_7_3', 'gen_5_7', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_5_7_4', 'gen_5_7', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_5_7_5', 'gen_5_7', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_5_7_6', 'gen_5_7', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_5_7_7', 'gen_5_7', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_5_7_8', 'gen_5_7', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_5_7_9', 'gen_5_7', 'What is 58 - 36?', '22', '24', '20'),
('q_gen_5_7_10', 'gen_5_7', 'What is 26 - 2?', '24', '25', '21') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_8', 'Science', 5, 8, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_8_1', 'gen_5_8', 'What do plants need?', 'Sunlight', 'Pizza', 'Toys'),
('q_gen_5_8_2', 'gen_5_8', 'Which is a liquid?', 'Water', 'Ice', 'Steam'),
('q_gen_5_8_3', 'gen_5_8', 'The sun is a...?', 'Star', 'Planet', 'Moon'),
('q_gen_5_8_4', 'gen_5_8', 'Frogs start as...?', 'Tadpoles', 'Eggs', 'Fish'),
('q_gen_5_8_5', 'gen_5_8', 'Birds have...?', 'Feathers', 'Fur', 'Scales'),
('q_gen_5_8_6', 'gen_5_8', 'Fish live in...?', 'Water', 'Trees', 'Dirt'),
('q_gen_5_8_7', 'gen_5_8', 'Which animal barks?', 'Dog', 'Cat', 'Cow'),
('q_gen_5_8_8', 'gen_5_8', 'Ice is frozen...?', 'Water', 'Milk', 'Juice'),
('q_gen_5_8_9', 'gen_5_8', 'What is 25 - 5?', '20', '23', '17'),
('q_gen_5_8_10', 'gen_5_8', 'What is 9 - 1?', '8', '11', '5') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_9', 'Social Studies', 5, 9, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_9_1', 'gen_5_9', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_5_9_2', 'gen_5_9', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_5_9_3', 'gen_5_9', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_5_9_4', 'gen_5_9', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_5_9_5', 'gen_5_9', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_5_9_6', 'gen_5_9', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_5_9_7', 'gen_5_9', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_5_9_8', 'gen_5_9', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_5_9_9', 'gen_5_9', 'What is 36 / 9?', '4', '5', '3'),
('q_gen_5_9_10', 'gen_5_9', 'What is 5 x 5?', '25', '30', '20') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('gen_5_10', 'Social Studies', 5, 10, FALSE) ON CONFLICT (id) DO UPDATE SET topic = EXCLUDED.topic, difficulty_level = EXCLUDED.difficulty_level;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('q_gen_5_10_1', 'gen_5_10', 'Firefighters drive...?', 'Trucks', 'Cars', 'Boats'),
('q_gen_5_10_2', 'gen_5_10', 'We learn at...?', 'School', 'Home', 'Park'),
('q_gen_5_10_3', 'gen_5_10', 'Red light means...?', 'Stop', 'Go', 'Run'),
('q_gen_5_10_4', 'gen_5_10', 'Green light means...?', 'Go', 'Stop', 'Wait'),
('q_gen_5_10_5', 'gen_5_10', 'Policemen help...?', 'Safe', 'Danger', 'Run'),
('q_gen_5_10_6', 'gen_5_10', 'USA flag colors?', 'Red White Blue', 'Green Yellow', 'Pink'),
('q_gen_5_10_7', 'gen_5_10', 'Mail carriers bring...?', 'Mail', 'Pizza', 'Toys'),
('q_gen_5_10_8', 'gen_5_10', 'Teachers help us...?', 'Learn', 'Sleep', 'Eat'),
('q_gen_5_10_9', 'gen_5_10', 'What is 56 / 7?', '8', '9', '7'),
('q_gen_5_10_10', 'gen_5_10', 'What is 76 - 33?', '43', '46', '41') ON CONFLICT (id) DO UPDATE SET question_text = EXCLUDED.question_text, correct_option = EXCLUDED.correct_option, wrong_option_1 = EXCLUDED.wrong_option_1, wrong_option_2 = EXCLUDED.wrong_option_2;
COMMIT;
