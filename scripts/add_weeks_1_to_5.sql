-- Week 1 (Grade 1 & 4)
-- Grade 1
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w1_g1_Math', 'Math', 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w1_g1_Math_q1', 'ch_Spring_2025_w1_g1_Math', 'How many fingers on one hand?', '5', '10', '2'),
('ch_Spring_2025_w1_g1_Math_q2', 'ch_Spring_2025_w1_g1_Math', 'Shape without corners?', 'Circle', 'Square', 'Triangle'),
('ch_Spring_2025_w1_g1_Math_q3', 'ch_Spring_2025_w1_g1_Math', 'What comes after 10?', '11', '9', '12'),
('ch_Spring_2025_w1_g1_Math_q4', 'ch_Spring_2025_w1_g1_Math', 'Count these stars: ***', '3', '4', '2'),
('ch_Spring_2025_w1_g1_Math_q5', 'ch_Spring_2025_w1_g1_Math', 'Which is smaller?', 'Ant', 'Dog', 'House')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w1_g4_Math', 'Math', 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w1_g4_Math_q1', 'ch_Spring_2025_w1_g4_Math', '500 + 500 = ?', '1000', '500', '2000'),
('ch_Spring_2025_w1_g4_Math_q2', 'ch_Spring_2025_w1_g4_Math', '12 x 2 = ?', '24', '14', '22'),
('ch_Spring_2025_w1_g4_Math_q3', 'ch_Spring_2025_w1_g4_Math', 'Value of 7 in 702?', '700', '70', '7'),
('ch_Spring_2025_w1_g4_Math_q4', 'ch_Spring_2025_w1_g4_Math', 'Half of 100?', '50', '25', '75'),
('ch_Spring_2025_w1_g4_Math_q5', 'ch_Spring_2025_w1_g4_Math', '3 x 4 = ?', '12', '7', '15')
ON CONFLICT (id) DO NOTHING;

-- Week 2 (Grade 1 & 4)
-- Grade 1
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w2_g1_Math', 'Math', 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w2_g1_Math_q1', 'ch_Spring_2025_w2_g1_Math', '10 + 5 = ?', '15', '12', '18'),
('ch_Spring_2025_w2_g1_Math_q2', 'ch_Spring_2025_w2_g1_Math', 'Which is bigger?', 'Elephant', 'Mouse', 'Ant'),
('ch_Spring_2025_w2_g1_Math_q3', 'ch_Spring_2025_w2_g1_Math', 'Sides on a square?', '4', '3', '5'),
('ch_Spring_2025_w2_g1_Math_q4', 'ch_Spring_2025_w2_g1_Math', '2 + 2 = ?', '4', '3', '5'),
('ch_Spring_2025_w2_g1_Math_q5', 'ch_Spring_2025_w2_g1_Math', '5 + 0 = ?', '5', '0', '10'),
('ch_Spring_2025_w2_g1_Math_q6', 'ch_Spring_2025_w2_g1_Math', 'One more than 7?', '8', '6', '9')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w2_g4_Math', 'Math', 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w2_g4_Math_q1', 'ch_Spring_2025_w2_g4_Math', '25 x 4 = ?', '100', '90', '110'),
('ch_Spring_2025_w2_g4_Math_q2', 'ch_Spring_2025_w2_g4_Math', '1/2 + 1/2 = ?', '1', '1/4', '2'),
('ch_Spring_2025_w2_g4_Math_q3', 'ch_Spring_2025_w2_g4_Math', 'Angles in a triangle sum to?', '180', '90', '360'),
('ch_Spring_2025_w2_g4_Math_q4', 'ch_Spring_2025_w2_g4_Math', '9 x 9 = ?', '81', '72', '90'),
('ch_Spring_2025_w2_g4_Math_q5', 'ch_Spring_2025_w2_g4_Math', '12 x 5 = ?', '60', '50', '70'),
('ch_Spring_2025_w2_g4_Math_q6', 'ch_Spring_2025_w2_g4_Math', '1/4 of 12?', '3', '4', '6')
ON CONFLICT (id) DO NOTHING;

-- Week 3
-- Grade 1
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w3_g1_Math', 'Math', 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w3_g1_Math_q1', 'ch_Spring_2025_w3_g1_Math', '20 - 5 = ?', '15', '10', '25'),
('ch_Spring_2025_w3_g1_Math_q2', 'ch_Spring_2025_w3_g1_Math', 'Dimes in a dollar?', '10', '5', '20'),
('ch_Spring_2025_w3_g1_Math_q3', 'ch_Spring_2025_w3_g1_Math', 'Clock shows 12:00. Time for?', 'Lunch', 'Sleep', 'Breakfast'),
('ch_Spring_2025_w3_g1_Math_q4', 'ch_Spring_2025_w3_g1_Math', '5 - 1 = ?', '4', '3', '6'),
('ch_Spring_2025_w3_g1_Math_q5', 'ch_Spring_2025_w3_g1_Math', '10 - 5 = ?', '5', '4', '6'),
('ch_Spring_2025_w3_g1_Math_q6', 'ch_Spring_2025_w3_g1_Math', 'Two less than 4?', '2', '3', '1')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w3_g4_Science', 'Science', 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w3_g4_Sci_q1', 'ch_Spring_2025_w3_g4_Science', 'Force that pulls down?', 'Gravity', 'Friction', 'Magnetism'),
('ch_Spring_2025_w3_g4_Sci_q2', 'ch_Spring_2025_w3_g4_Science', 'Photosynthesis needs?', 'Sunlight', 'Moonlight', 'Flashlight'),
('ch_Spring_2025_w3_g4_Sci_q3', 'ch_Spring_2025_w3_g4_Science', 'Solid to Liquid is?', 'Melting', 'Freezing', 'Boiling'),
('ch_Spring_2025_w3_g4_Sci_q4', 'ch_Spring_2025_w3_g4_Science', 'Heat comes from the?', 'Sun', 'Moon', 'Clouds'),
('ch_Spring_2025_w3_g4_Sci_q5', 'ch_Spring_2025_w3_g4_Science', 'Water boils at?', '100 C', '0 C', '50 C'),
('ch_Spring_2025_w3_g4_Sci_q6', 'ch_Spring_2025_w3_g4_Science', 'Magnet pulls?', 'Iron', 'Wood', 'Plastic')
ON CONFLICT (id) DO NOTHING;

-- Week 4
-- Grade 1
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w4_g1_Science', 'Science', 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w4_g1_Sci_q1', 'ch_Spring_2025_w4_g1_Science', 'Tadpole becomes a?', 'Frog', 'Dog', 'Fish'),
('ch_Spring_2025_w4_g1_Sci_q2', 'ch_Spring_2025_w4_g1_Science', 'Sun rises in the?', 'East', 'West', 'North'),
('ch_Spring_2025_w4_g1_Sci_q3', 'ch_Spring_2025_w4_g1_Science', 'Ice is water that is?', 'Frozen', 'Hot', 'Gas'),
('ch_Spring_2025_w4_g1_Sci_q4', 'ch_Spring_2025_w4_g1_Science', 'What do plants need?', 'Water', 'Candy', 'Toys'),
('ch_Spring_2025_w4_g1_Sci_q5', 'ch_Spring_2025_w4_g1_Science', 'A seed grows into a?', 'Plant', 'Rock', 'Bird'),
('ch_Spring_2025_w4_g1_Sci_q6', 'ch_Spring_2025_w4_g1_Science', 'The sky is?', 'Up', 'Down', 'Side')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w4_g4_Math', 'Math', 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w4_g4_Math_q1', 'ch_Spring_2025_w4_g4_Math', '120 / 10 = ?', '12', '10', '20'),
('ch_Spring_2025_w4_g4_Math_q2', 'ch_Spring_2025_w4_g4_Math', 'Area of 5x6 rect?', '30', '11', '25'),
('ch_Spring_2025_w4_g4_Math_q3', 'ch_Spring_2025_w4_g4_Math', '0.5 as a fraction?', '1/2', '1/5', '5/100'),
('ch_Spring_2025_w4_g4_Math_q4', 'ch_Spring_2025_w4_g4_Math', '81 / 9 = ?', '9', '8', '7'),
('ch_Spring_2025_w4_g4_Math_q5', 'ch_Spring_2025_w4_g4_Math', 'Area of 10x10 square?', '100', '20', '50'),
('ch_Spring_2025_w4_g4_Math_q6', 'ch_Spring_2025_w4_g4_Math', '0.75 as fraction?', '3/4', '1/4', '1/2')
ON CONFLICT (id) DO NOTHING;

-- Week 5
-- Grade 1
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w5_g1_Social', 'Social Studies', 1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w5_g1_Soc_q1', 'ch_Spring_2025_w5_g1_Social', 'Rules keep us?', 'Safe', 'Sad', 'Hungry'),
('ch_Spring_2025_w5_g1_Soc_q2', 'ch_Spring_2025_w5_g1_Social', 'Money we use?', 'Dollars', 'Leaves', 'Rocks'),
('ch_Spring_2025_w5_g1_Soc_q3', 'ch_Spring_2025_w5_g1_Social', 'Traffic Red light?', 'Stop', 'Go', 'Run'),
('ch_Spring_2025_w5_g1_Soc_q4', 'ch_Spring_2025_w5_g1_Social', 'A doctor helps?', 'Sick people', 'Animals only', 'Cars'),
('ch_Spring_2025_w5_g1_Soc_q5', 'ch_Spring_2025_w5_g1_Social', 'Police ride in a?', 'Police car', 'Bus', 'Bike'),
('ch_Spring_2025_w5_g1_Soc_q6', 'ch_Spring_2025_w5_g1_Social', 'We live on planet?', 'Earth', 'Mars', 'Moon')
ON CONFLICT (id) DO NOTHING;

-- Grade 4
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w5_g4_Social', 'Social Studies', 4) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('ch_Spring_2025_w5_g4_Soc_q1', 'ch_Spring_2025_w5_g4_Social', 'Declaration of Independence year?', '1776', '1999', '1492'),
('ch_Spring_2025_w5_g4_Soc_q2', 'ch_Spring_2025_w5_g4_Social', 'Capital of Texas?', 'Austin', 'Houston', 'Dallas'),
('ch_Spring_2025_w5_g4_Soc_q3', 'ch_Spring_2025_w5_g4_Social', 'Study of the past?', 'History', 'Math', 'Science'),
('ch_Spring_2025_w5_g4_Soc_q4', 'ch_Spring_2025_w5_g4_Social', 'First person on Moon?', 'Armstrong', 'Columbus', 'Newton'),
('ch_Spring_2025_w5_g4_Soc_q5', 'ch_Spring_2025_w5_g4_Social', 'Number of continents?', '7', '5', '10'),
('ch_Spring_2025_w5_g4_Soc_q6', 'ch_Spring_2025_w5_g4_Social', 'Laws are made by?', 'Government', 'Schools', 'Stores')
ON CONFLICT (id) DO NOTHING;
