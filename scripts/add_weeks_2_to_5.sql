-- Week 2 (Grade 1 & 4)
-- Grade 1
INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('ch_Spring_2025_w2_g1_Math', 'Math', 'Spring 2025', 2, 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w2_g1_Math_q1', 'ch_Spring_2025_w2_g1_Math', '10 + 5 = ?', '15', '12', '18'),
('ch_Spring_2025_w2_g1_Math_q2', 'ch_Spring_2025_w2_g1_Math', 'Which is bigger?', 'Elephant', 'Mouse', 'Ant'),
('ch_Spring_2025_w2_g1_Math_q3', 'ch_Spring_2025_w2_g1_Math', 'Sides on a square?', '4', '3', '5')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('ch_Spring_2025_w2_g4_Math', 'Math', 'Spring 2025', 2, 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w2_g4_Math_q1', 'ch_Spring_2025_w2_g4_Math', '25 x 4 = ?', '100', '90', '110'),
('ch_Spring_2025_w2_g4_Math_q2', 'ch_Spring_2025_w2_g4_Math', '1/2 + 1/2 = ?', '1', '1/4', '2'),
('ch_Spring_2025_w2_g4_Math_q3', 'ch_Spring_2025_w2_g4_Math', 'Angles in a triangle sum to?', '180', '90', '360')
ON CONFLICT (id) DO NOTHING;

-- Week 3
-- Grade 1
INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('ch_Spring_2025_w3_g1_Math', 'Math', 'Spring 2025', 3, 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w3_g1_Math_q1', 'ch_Spring_2025_w3_g1_Math', '20 - 5 = ?', '15', '10', '25'),
('ch_Spring_2025_w3_g1_Math_q2', 'ch_Spring_2025_w3_g1_Math', 'Dimes in a dollar?', '10', '5', '20'),
('ch_Spring_2025_w3_g1_Math_q3', 'ch_Spring_2025_w3_g1_Math', 'Clock shows 12:00. Time for?', 'Lunch', 'Sleep', 'Breakfast')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('ch_Spring_2025_w3_g4_Science', 'Science', 'Spring 2025', 3, 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w3_g4_Sci_q1', 'ch_Spring_2025_w3_g4_Science', 'Force that pulls down?', 'Gravity', 'Friction', 'Magnetism'),
('ch_Spring_2025_w3_g4_Sci_q2', 'ch_Spring_2025_w3_g4_Science', 'Photosynthesis needs?', 'Sunlight', 'Moonlight', 'Flashlight'),
('ch_Spring_2025_w3_g4_Sci_q3', 'ch_Spring_2025_w3_g4_Science', 'Solid to Liquid is?', 'Melting', 'Freezing', 'Boiling')
ON CONFLICT (id) DO NOTHING;

-- Week 4
-- Grade 1
INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('ch_Spring_2025_w4_g1_Science', 'Science', 'Spring 2025', 4, 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w4_g1_Sci_q1', 'ch_Spring_2025_w4_g1_Science', 'Tadpole becomes a?', 'Frog', 'Dog', 'Fish'),
('ch_Spring_2025_w4_g1_Sci_q2', 'ch_Spring_2025_w4_g1_Science', 'Sun rises in the?', 'East', 'West', 'North'),
('ch_Spring_2025_w4_g1_Sci_q3', 'ch_Spring_2025_w4_g1_Science', 'Ice is water that is?', 'Frozen', 'Hot', 'Gas')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('ch_Spring_2025_w4_g4_Math', 'Math', 'Spring 2025', 4, 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w4_g4_Math_q1', 'ch_Spring_2025_w4_g4_Math', '120 / 10 = ?', '12', '10', '20'),
('ch_Spring_2025_w4_g4_Math_q2', 'ch_Spring_2025_w4_g4_Math', 'Area of 5x6 rect?', '30', '11', '25'),
('ch_Spring_2025_w4_g4_Math_q3', 'ch_Spring_2025_w4_g4_Math', '0.5 as a fraction?', '1/2', '1/5', '5/100')
ON CONFLICT (id) DO NOTHING;

-- Week 5
-- Grade 1
INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('ch_Spring_2025_w5_g1_Social', 'Social Studies', 'Spring 2025', 5, 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w5_g1_Soc_q1', 'ch_Spring_2025_w5_g1_Social', 'Rules keep us?', 'Safe', 'Sad', 'Hungry'),
('ch_Spring_2025_w5_g1_Soc_q2', 'ch_Spring_2025_w5_g1_Social', 'Money we use?', 'Dollars', 'Leaves', 'Rocks'),
('ch_Spring_2025_w5_g1_Soc_q3', 'ch_Spring_2025_w5_g1_Social', 'Traffic Red light?', 'Stop', 'Go', 'Run')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, season, week_number, grade_level) VALUES ('ch_Spring_2025_w5_g4_Social', 'Social Studies', 'Spring 2025', 5, 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w5_g4_Soc_q1', 'ch_Spring_2025_w5_g4_Social', 'Declaration of Independence year?', '1776', '1999', '1492'),
('ch_Spring_2025_w5_g4_Soc_q2', 'ch_Spring_2025_w5_g4_Social', 'Capital of Texas?', 'Austin', 'Houston', 'Dallas'),
('ch_Spring_2025_w5_g4_Soc_q3', 'ch_Spring_2025_w5_g4_Social', 'Study of the past?', 'History', 'Math', 'Science')
ON CONFLICT (id) DO NOTHING;
