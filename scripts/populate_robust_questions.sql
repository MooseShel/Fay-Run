-- =============================================================
-- ROBUST QUESTION POPULATION (Fixes Low Question Count)
-- =============================================================
-- This script deletes existing sparse data for Grade 1 and 4
-- and repopulates them with a RICH set of questions (15+ per level).
-- It ensures you don't run out of questions during a run.

BEGIN;

-- 1. CLEANUP (Only targeted grades to avoid destroying everything if not needed)
DELETE FROM student_progress WHERE challenge_id IN (SELECT id FROM challenges WHERE grade_level IN (1, 4) AND is_exam = FALSE);
DELETE FROM questions WHERE challenge_id IN (SELECT id FROM challenges WHERE grade_level IN (1, 4) AND is_exam = FALSE);
DELETE FROM challenges WHERE grade_level IN (1, 4) AND is_exam = FALSE;

-- =============================================================
-- GRADE 1 (15+ Questions per Level)
-- =============================================================

-- Level 1: Sums up to 20 (The Basics)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('g1_d1', 'Math', 1, 1, FALSE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('g1_d1_1', 'g1_d1', '10 + 10 = ?', '20', '10', '30'),
('g1_d1_2', 'g1_d1', '5 + 5 = ?', '10', '5', '15'),
('g1_d1_3', 'g1_d1', '10 + 5 = ?', '15', '12', '18'),
('g1_d1_4', 'g1_d1', '2 + 8 = ?', '10', '9', '11'),
('g1_d1_5', 'g1_d1', 'What is 10 minus 2?', '8', '7', '9'),
('g1_d1_6', 'g1_d1', 'What is 15 minus 5?', '10', '5', '20'),
('g1_d1_7', 'g1_d1', '3 + 7 = ?', '10', '11', '13'),
('g1_d1_8', 'g1_d1', '12 + 0 = ?', '12', '10', '0'),
('g1_d1_9', 'g1_d1', '6 + 6 = ?', '12', '10', '14'),
('g1_d1_10', 'g1_d1', '10 + 2 = ?', '12', '11', '20'),
('g1_d1_11', 'g1_d1', '10 - 10 = ?', '0', '10', '20'),
('g1_d1_12', 'g1_d1', '10 + 1 = ?', '11', '10', '12'),
('g1_d1_13', 'g1_d1', '4 + 4 = ?', '8', '6', '10'),
('g1_d1_14', 'g1_d1', '9 + 1 = ?', '10', '9', '11'),
('g1_d1_15', 'g1_d1', '7 + 7 = ?', '14', '12', '15');

-- Level 2: Subtraction & Tens
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('g1_d2', 'Math', 1, 2, FALSE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('g1_d2_1', 'g1_d2', '20 - 10 = ?', '10', '5', '15'),
('g1_d2_2', 'g1_d2', '15 - 5 = ?', '10', '5', '20'),
('g1_d2_3', 'g1_d2', '18 - 8 = ?', '10', '8', '9'),
('g1_d2_4', 'g1_d2', '10 + 20 = ?', '30', '20', '40'),
('g1_d2_5', 'g1_d2', '30 - 10 = ?', '20', '10', '15'),
('g1_d2_6', 'g1_d2', '25 - 5 = ?', '20', '10', '15'),
('g1_d2_7', 'g1_d2', '5 + 5 + 5 = ?', '15', '10', '20'),
('g1_d2_8', 'g1_d2', '10 + 10 + 10 = ?', '30', '20', '10'),
('g1_d2_9', 'g1_d2', 'What is 40 minus 10?', '30', '20', '50'),
('g1_d2_10', 'g1_d2', '2 + 2 + 2 = ?', '6', '4', '8'),
('g1_d2_11', 'g1_d2', '100 is equal to...?', '10 tens', '5 tens', '1 ten'),
('g1_d2_12', 'g1_d2', '50 has how many tens?', '5', '10', '0');

-- Level 3: Measurement (Inches & Feet)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('g1_d3', 'Math', 1, 3, FALSE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('g1_d3_1', 'g1_d3', 'Which is bigger?', 'Foot', 'Inch', 'Centimeter'),
('g1_d3_2', 'g1_d3', '12 inches is equal to?', '1 Foot', '1 Yard', '1 Meter'),
('g1_d3_3', 'g1_d3', 'A ruler usually has?', '12 Inches', '10 Inches', '5 Inches'),
('g1_d3_4', 'g1_d3', 'Measure a pencil with?', 'Inches', 'Feet', 'Yards'),
('g1_d3_5', 'g1_d3', 'Measure a bus with?', 'Feet', 'Inches', 'Paperclips'),
('g1_d3_6', 'g1_d3', 'Is a Paperclip 1 inch or 1 foot?', '1 inch', '1 foot', '1 yard'),
('g1_d3_7', 'g1_d3', '3 feet is equal to?', '1 Yard', '1 Inch', '1 Mile'),
('g1_d3_8', 'g1_d3', 'Which is smallest?', 'Inch', 'Foot', 'Yard'),
('g1_d3_9', 'g1_d3', 'How many feet in a yard?', '3', '10', '12'),
('g1_d3_10', 'g1_d3', 'Measuring tape measures?', 'Length', 'Weight', 'Time');

-- =============================================================
-- GRADE 4 (15+ Questions per Level)
-- =============================================================

-- Level 1: Multiplication Basics & Addition
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('g4_d1', 'Math', 4, 1, FALSE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('g4_d1_1', 'g4_d1', '500 + 500 = ?', '1000', '500', '2000'),
('g4_d1_2', 'g4_d1', '300 + 200 = ?', '500', '600', '400'),
('g4_d1_3', 'g4_d1', '6 x 2 = ?', '12', '8', '14'),
('g4_d1_4', 'g4_d1', '7 x 3 = ?', '21', '20', '24'),
('g4_d1_5', 'g4_d1', '8 x 4 = ?', '32', '28', '36'),
('g4_d1_6', 'g4_d1', '9 x 2 = ?', '18', '19', '20'),
('g4_d1_7', 'g4_d1', '50 + 50 + 50 = ?', '150', '100', '200'),
('g4_d1_8', 'g4_d1', '10 x 10 = ?', '100', '1000', '50'),
('g4_d1_9', 'g4_d1', '12 x 2 = ?', '24', '14', '22'),
('g4_d1_10', 'g4_d1', '11 + 11 = ?', '22', '20', '21'),
('g4_d1_11', 'g4_d1', '100 - 25 = ?', '75', '85', '65'),
('g4_d1_12', 'g4_d1', '40 x 2 = ?', '80', '42', '60'),
('g4_d1_13', 'g4_d1', 'What is 4 squared?', '16', '8', '12'),
('g4_d1_14', 'g4_d1', 'What is half of 50?', '25', '20', '30'),
('g4_d1_15', 'g4_d1', 'What is double 15?', '30', '40', '25');

-- Level 2: Division & Geometry
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('g4_d2', 'Math', 4, 2, FALSE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('g4_d2_1', 'g4_d2', '12 x 12 = ?', '144', '124', '134'),
('g4_d2_2', 'g4_d2', '100 / 10 = ?', '10', '100', '5'),
('g4_d2_3', 'g4_d2', '81 / 9 = ?', '9', '8', '7'),
('g4_d2_4', 'g4_d2', 'Perimeter of a square with side 4?', '16', '12', '8'),
('g4_d2_5', 'g4_d2', 'Area of a 3x3 square?', '9', '12', '6'),
('g4_d2_6', 'g4_d2', 'Triangle has how many sides?', '3', '4', '5'),
('g4_d2_7', 'g4_d2', 'Hexagon has how many sides?', '6', '5', '8'),
('g4_d2_8', 'g4_d2', '40 / 4 = ?', '10', '20', '5'),
('g4_d2_9', 'g4_d2', 'How many degrees in a right angle?', '90', '180', '45'),
('g4_d2_10', 'g4_d2', 'Pentagon has how many sides?', '5', '6', '4'),
('g4_d2_11', 'g4_d2', '24 / 6 = ?', '4', '6', '3'),
('g4_d2_12', 'g4_d2', '32 / 8 = ?', '4', '8', '2');

-- Level 3: Fractions
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES ('g4_d3', 'Math', 4, 3, FALSE);
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
('g4_d3_1', 'g4_d3', '1/2 + 1/2 = ?', '1', '2', '1/2'),
('g4_d3_2', 'g4_d3', 'Which is bigger: 1/4 or 1/2?', '1/2', '1/4', 'Same'),
('g4_d3_3', 'g4_d3', 'Top number of a fraction is?', 'Numerator', 'Denominator', 'Divisor'),
('g4_d3_4', 'g4_d3', 'Bottom number of a fraction is?', 'Denominator', 'Numerator', 'Quotient'),
('g4_d3_5', 'g4_d3', 'What is 50% of 100?', '50', '25', '10'),
('g4_d3_6', 'g4_d3', '3/4 is equal to?', '0.75', '0.25', '0.50'),
('g4_d3_7', 'g4_d3', '1 as a fraction?', '1/1', '0/1', '1/0'),
('g4_d3_8', 'g4_d3', 'Equivalent to 2/4?', '1/2', '1/3', '1/5'),
('g4_d3_9', 'g4_d3', '0.5 is the same as?', '1/2', '1/4', '1/10'),
('g4_d3_10', 'g4_d3', '0.25 is the same as?', '1/4', '1/2', '3/4');

COMMIT;
