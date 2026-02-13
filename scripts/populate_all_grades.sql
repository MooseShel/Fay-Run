-- ==========================================
-- PRE-K 3 (Grade Level -2)
-- ==========================================

-- Week 1: Math (Colors & Shapes) -> Difficulty 1 & 2
INSERT INTO challenges (id, topic, grade_level, difficulty_level) VALUES 
('ch_prek3_d1_Math', 'Math', -2, 1),
('ch_prek3_d2_Math', 'Math', -2, 2)
ON CONFLICT (id) DO UPDATE SET difficulty_level = EXCLUDED.difficulty_level;

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek3_w1_1', 'ch_prek3_d1_Math', 'What color is the sun?', 'Yellow', 'Blue', 'Green'),
('q_prek3_w1_2', 'ch_prek3_d1_Math', 'What shape is a ball?', 'Circle', 'Square', 'Triangle'),
('q_prek3_w1_3', 'ch_prek3_d2_Math', 'Which one is BIG?', 'Elephant', 'Ant', 'Mouse'),
('q_prek3_w1_4', 'ch_prek3_d2_Math', 'Count the eyes: 👀', 'Two', 'One', 'Three'),
('q_prek3_w1_5', 'ch_prek3_d2_Math', 'What color is an apple?', 'Red', 'Blue', 'Purple')
ON CONFLICT (id) DO UPDATE SET 
  question_text = EXCLUDED.question_text,
  challenge_id = EXCLUDED.challenge_id;

-- Week 2: Math (Counting & Sizes) -> Difficulty 3 & 4
INSERT INTO challenges (id, topic, grade_level, difficulty_level) VALUES 
('ch_prek3_d3_Math', 'Math', -2, 3),
('ch_prek3_d4_Math', 'Math', -2, 4)
ON CONFLICT (id) DO UPDATE SET difficulty_level = EXCLUDED.difficulty_level;

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek3_w2_1', 'ch_prek3_d3_Math', 'How many fingers?', 'Five', 'Two', 'Ten'),
('q_prek3_w2_2', 'ch_prek3_d3_Math', 'Which is Small?', 'Mouse', 'House', 'Tree'),
('q_prek3_w2_3', 'ch_prek3_d4_Math', 'Count: 🍎 🍎', 'Two', 'One', 'Three'),
('q_prek3_w2_4', 'ch_prek3_d4_Math', 'Shape with 4 sides?', 'Square', 'Circle', 'Star'),
('q_prek3_w2_5', 'ch_prek3_d4_Math', 'Which is heavier?', 'Car', 'Feather', 'Ball')
ON CONFLICT (id) DO UPDATE SET 
  question_text = EXCLUDED.question_text,
  challenge_id = EXCLUDED.challenge_id;

-- Week 3: Science (Animals)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w3_prek3_Sci', 'Science', -2) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek3_w3_1', 'ch_Spring_2025_w3_prek3_Sci', 'What says "Meow"?', 'Cat', 'Dog', 'Cow'),
('q_prek3_w3_2', 'ch_Spring_2025_w3_prek3_Sci', 'What says "Woof"?', 'Dog', 'Cat', 'Bird'),
('q_prek3_w3_3', 'ch_Spring_2025_w3_prek3_Sci', 'What flies in the sky?', 'Bird', 'Fish', 'Dog'),
('q_prek3_w3_4', 'ch_Spring_2025_w3_prek3_Sci', 'Where do fish live?', 'Water', 'Tree', 'House'),
('q_prek3_w3_5', 'ch_Spring_2025_w3_prek3_Sci', 'An elephant has a long?', 'Trunk', 'Tail', 'Ear')
ON CONFLICT (id) DO NOTHING;

-- Week 4: Science (Nature)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w4_prek3_Sci', 'Science', -2) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek3_w4_1', 'ch_Spring_2025_w4_prek3_Sci', 'The sun is?', 'Hot', 'Cold', 'Wet'),
('q_prek3_w4_2', 'ch_Spring_2025_w4_prek3_Sci', 'Ice is?', 'Cold', 'Hot', 'Dry'),
('q_prek3_w4_3', 'ch_Spring_2025_w4_prek3_Sci', 'Rain is?', 'Wet', 'Dry', 'Funny'),
('q_prek3_w4_4', 'ch_Spring_2025_w4_prek3_Sci', 'Grass is usually?', 'Green', 'Blue', 'Red'),
('q_prek3_w4_5', 'ch_Spring_2025_w4_prek3_Sci', 'We sleep at?', 'Night', 'Day', 'Lunch')
ON CONFLICT (id) DO NOTHING;

-- Week 5: Social Studies (Me & Family)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w5_prek3_Soc', 'Social Studies', -2) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek3_w5_1', 'ch_Spring_2025_w5_prek3_Soc', 'We hold hands to be?', 'Safe', 'Fast', 'Loud'),
('q_prek3_w5_2', 'ch_Spring_2025_w5_prek3_Soc', 'When we share we count?', 'Friends', 'Toes', 'Cars'),
('q_prek3_w5_3', 'ch_Spring_2025_w5_prek3_Soc', 'Brush teeth every?', 'Day', 'Week', 'Month'),
('q_prek3_w5_4', 'ch_Spring_2025_w5_prek3_Soc', 'Listen to?', 'Teacher', 'Dog', 'Tree'),
('q_prek3_w5_5', 'ch_Spring_2025_w5_prek3_Soc', 'Say "Please" and?', 'Thank You', 'No', 'Bye')
ON CONFLICT (id) DO NOTHING;


-- ==========================================
-- PRE-K 4 (Grade Level -1)
-- ==========================================

-- Week 1: Math (Counting 1-10)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w1_prek4_Math', 'Math', -1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek4_w1_1', 'ch_Spring_2025_w1_prek4_Math', 'Count: ⭐️ ⭐️ ⭐️', '3', '2', '4'),
('q_prek4_w1_2', 'ch_Spring_2025_w1_prek4_Math', 'What comes after 4?', '5', '3', '6'),
('q_prek4_w1_3', 'ch_Spring_2025_w1_prek4_Math', 'Identify the number: 7', 'Seven', 'Six', 'Eight'),
('q_prek4_w1_4', 'ch_Spring_2025_w1_prek4_Math', 'Which has more?', '5 Blocks', '1 Block', '2 Blocks'),
('q_prek4_w1_5', 'ch_Spring_2025_w1_prek4_Math', '2 + 1 = ?', '3', '2', '4')
ON CONFLICT (id) DO NOTHING;

-- Week 2: Math (Shapes & Patterns)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w2_prek4_Math', 'Math', -1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek4_w2_1', 'ch_Spring_2025_w2_prek4_Math', 'Red, Blue, Red...?', 'Blue', 'Green', 'Yellow'),
('q_prek4_w2_2', 'ch_Spring_2025_w2_prek4_Math', 'Shape with 3 sides?', 'Triangle', 'Square', 'Circle'),
('q_prek4_w2_3', 'ch_Spring_2025_w2_prek4_Math', 'How many corners on a square?', '4', '3', '0'),
('q_prek4_w2_4', 'ch_Spring_2025_w2_prek4_Math', 'Is a wheel round?', 'Yes', 'No', 'Maybe'),
('q_prek4_w2_5', 'ch_Spring_2025_w2_prek4_Math', 'Tallest animal?', 'Giraffe', 'Cat', 'Dog')
ON CONFLICT (id) DO NOTHING;

-- Week 3: Science (Senses)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w3_prek4_Sci', 'Science', -1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek4_w3_1', 'ch_Spring_2025_w3_prek4_Sci', 'We see with our?', 'Eyes', 'Ears', 'Nose'),
('q_prek4_w3_2', 'ch_Spring_2025_w3_prek4_Sci', 'We smell with our?', 'Nose', 'Eyes', 'Mouth'),
('q_prek4_w3_3', 'ch_Spring_2025_w3_prek4_Sci', 'Ice cream feels?', 'Cold', 'Hot', 'Sharp'),
('q_prek4_w3_4', 'ch_Spring_2025_w3_prek4_Sci', 'A drum sound is?', 'Loud', 'Quiet', 'Soft'),
('q_prek4_w3_5', 'ch_Spring_2025_w3_prek4_Sci', 'Candy tastes?', 'Sweet', 'Sour', 'Salty')
ON CONFLICT (id) DO NOTHING;

-- Week 4: Science (Weather)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w4_prek4_Sci', 'Science', -1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek4_w4_1', 'ch_Spring_2025_w4_prek4_Sci', 'Wear this in rain?', 'Raincoat', 'Swimsuit', 'Pajamas'),
('q_prek4_w4_2', 'ch_Spring_2025_w4_prek4_Sci', 'White fluffy thing in sky?', 'Cloud', 'Cotton', 'Sheep'),
('q_prek4_w4_3', 'ch_Spring_2025_w4_prek4_Sci', 'When snow falls it is?', 'Winter', 'Summer', 'Spring'),
('q_prek4_w4_4', 'ch_Spring_2025_w4_prek4_Sci', 'Sun makes us feel?', 'Warm', 'Cold', 'Wet'),
('q_prek4_w4_5', 'ch_Spring_2025_w4_prek4_Sci', 'Wind moves the?', 'Trees', 'Houses', 'Roads')
ON CONFLICT (id) DO NOTHING;

-- Week 5: Social Studies (Helpers)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w5_prek4_Soc', 'Social Studies', -1) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_prek4_w5_1', 'ch_Spring_2025_w5_prek4_Soc', 'Who puts out fires?', 'Firefighter', 'Baker', 'Artist'),
('q_prek4_w5_2', 'ch_Spring_2025_w5_prek4_Soc', 'Who helps when sick?', 'Doctor', 'Chef', 'Farmer'),
('q_prek4_w5_3', 'ch_Spring_2025_w5_prek4_Soc', 'Who delivers mail?', 'Mail Carrier', 'Teacher', 'Pilot'),
('q_prek4_w5_4', 'ch_Spring_2025_w5_prek4_Soc', 'Stop sign color?', 'Red', 'Green', 'Blue'),
('q_prek4_w5_5', 'ch_Spring_2025_w5_prek4_Soc', 'We learn at?', 'School', 'Zoo', 'Park')
ON CONFLICT (id) DO NOTHING;


-- ==========================================
-- KINDERGARTEN (Grade Level 0)
-- ==========================================

-- Week 1: Math (Numbers 1-20)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w1_K_Math', 'Math', 0) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_k_w1_1', 'ch_Spring_2025_w1_K_Math', 'Count fingers on 2 hands?', '10', '5', '8'),
('q_k_w1_2', 'ch_Spring_2025_w1_K_Math', 'What comes after 9?', '10', '8', '11'),
('q_k_w1_3', 'ch_Spring_2025_w1_K_Math', '3 + 2 = ?', '5', '4', '6'),
('q_k_w1_4', 'ch_Spring_2025_w1_K_Math', 'Which number is biggest?', '20', '12', '2'),
('q_k_w1_5', 'ch_Spring_2025_w1_K_Math', '5 - 1 = ?', '4', '3', '5')
ON CONFLICT (id) DO NOTHING;

-- Week 2: Math (Comparison)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w2_K_Math', 'Math', 0) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_k_w2_1', 'ch_Spring_2025_w2_K_Math', 'Which is heavier?', 'Desk', 'Pencil', 'Paper'),
('q_k_w2_2', 'ch_Spring_2025_w2_K_Math', 'Which is longer?', 'Snake', 'Worm', 'Caterpillar'),
('q_k_w2_3', 'ch_Spring_2025_w2_K_Math', 'More than 5?', '10', '4', '2'),
('q_k_w2_4', 'ch_Spring_2025_w2_K_Math', 'Less than 3?', '1', '4', '5'),
('q_k_w2_5', 'ch_Spring_2025_w2_K_Math', 'Shape with no corners?', 'Circle', 'Square', 'Triangle')
ON CONFLICT (id) DO NOTHING;

-- Week 3: Science (Living Things)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w3_K_Sci', 'Science', 0) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_k_w3_1', 'ch_Spring_2025_w3_K_Sci', 'Do plants grow?', 'Yes', 'No', 'Maybe'),
('q_k_w3_2', 'ch_Spring_2025_w3_K_Sci', 'A rock is?', 'Non-living', 'Living', 'Asleep'),
('q_k_w3_3', 'ch_Spring_2025_w3_K_Sci', 'Animals need?', 'Food', 'Toys', 'Money'),
('q_k_w3_4', 'ch_Spring_2025_w3_K_Sci', 'Baby dog is a?', 'Puppy', 'Kitten', 'Cub'),
('q_k_w3_5', 'ch_Spring_2025_w3_K_Sci', 'Birds have?', 'Feathers', 'Scales', 'Fur')
ON CONFLICT (id) DO NOTHING;

-- Week 4: Science (Seasons)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w4_K_Sci', 'Science', 0) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_k_w4_1', 'ch_Spring_2025_w4_K_Sci', 'Snow falls in?', 'Winter', 'Summer', 'Fall'),
('q_k_w4_2', 'ch_Spring_2025_w4_K_Sci', 'Flowers bloom in?', 'Spring', 'Winter', 'Fall'),
('q_k_w4_3', 'ch_Spring_2025_w4_K_Sci', 'Leaves fall in?', 'Autumn', 'Spring', 'Summer'),
('q_k_w4_4', 'ch_Spring_2025_w4_K_Sci', 'Hot swimming time?', 'Summer', 'Winter', 'Spring'),
('q_k_w4_5', 'ch_Spring_2025_w4_K_Sci', 'Hibernation is?', 'Sleep all winter', 'Run fast', 'Eat a lot')
ON CONFLICT (id) DO NOTHING;

-- Week 5: Social Studies (Citizenship)
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w5_K_Soc', 'Social Studies', 0) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_k_w5_1', 'ch_Spring_2025_w5_K_Soc', 'A good rule is?', 'Be Kind', 'Hit', 'Yell'),
('q_k_w5_2', 'ch_Spring_2025_w5_K_Soc', 'Voting means?', 'Choosing', 'Running', 'Sleeping'),
('q_k_w5_3', 'ch_Spring_2025_w5_K_Soc', 'Our country is?', 'USA', 'Texas', 'Houston'),
('q_k_w5_4', 'ch_Spring_2025_w5_K_Soc', 'Flag has stars and?', 'Stripes', 'Dots', 'Circles'),
('q_k_w5_5', 'ch_Spring_2025_w5_K_Soc', 'Presidents live in?', 'White House', 'Blue House', 'Red Barn')
ON CONFLICT (id) DO NOTHING;


-- ==========================================
-- 2ND GRADE (Grade Level 2)
-- ==========================================

-- Week 1: Math
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w1_g2_Math', 'Math', 2) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g2_w1_1', 'ch_Spring_2025_w1_g2_Math', '15 + 10 = ?', '25', '20', '30'),
('q_g2_w1_2', 'ch_Spring_2025_w1_g2_Math', '100 - 10 = ?', '90', '80', '110'),
('q_g2_w1_3', 'ch_Spring_2025_w1_g2_Math', 'Value of 5 in 52?', '50', '5', '500'),
('q_g2_w1_4', 'ch_Spring_2025_w1_g2_Math', 'Even number?', '24', '23', '25'),
('q_g2_w1_5', 'ch_Spring_2025_w1_g2_Math', 'Sides on a Hexagon?', '6', '5', '8')
ON CONFLICT (id) DO NOTHING;

-- Week 2: Math
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w2_g2_Math', 'Math', 2) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g2_w2_1', 'ch_Spring_2025_w2_g2_Math', '25 cents is a?', 'Quarter', 'Dime', 'Nickel'),
('q_g2_w2_2', 'ch_Spring_2025_w2_g2_Math', 'How many mins in hour?', '60', '100', '30'),
('q_g2_w2_3', 'ch_Spring_2025_w2_g2_Math', 'Half past 3 is?', '3:30', '3:15', '4:00'),
('q_g2_w2_4', 'ch_Spring_2025_w2_g2_Math', '10 + 10 + 5 = ?', '25', '20', '30'),
('q_g2_w2_5', 'ch_Spring_2025_w2_g2_Math', '1 dollar = ? pennies', '100', '10', '50')
ON CONFLICT (id) DO NOTHING;

-- Week 3: Science
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w3_g2_Sci', 'Science', 2) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g2_w3_1', 'ch_Spring_2025_w3_g2_Sci', 'Solid turning to liquid?', 'Melting', 'Freezing', 'Evaporating'),
('q_g2_w3_2', 'ch_Spring_2025_w3_g2_Sci', 'Gas we breathe?', 'Oxygen', 'Helium', 'Water'),
('q_g2_w3_3', 'ch_Spring_2025_w3_g2_Sci', 'Magnet pulls?', 'Metal', 'Plastic', 'Wood'),
('q_g2_w3_4', 'ch_Spring_2025_w3_g2_Sci', 'Planet we live on?', 'Earth', 'Mars', 'Venus'),
('q_g2_w3_5', 'ch_Spring_2025_w3_g2_Sci', 'Sound is caused by?', 'Vibration', 'Light', 'Heat')
ON CONFLICT (id) DO NOTHING;

-- Week 4: Science
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w4_g2_Sci', 'Science', 2) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g2_w4_1', 'ch_Spring_2025_w4_g2_Sci', 'Animal with pouch?', 'Kangaroo', 'Lion', 'Bear'),
('q_g2_w4_2', 'ch_Spring_2025_w4_g2_Sci', 'Frog life cycle start?', 'Egg', 'Tadpole', 'Froglet'),
('q_g2_w4_3', 'ch_Spring_2025_w4_g2_Sci', 'Food chain starts with?', 'Sun/Plants', 'Animals', 'Humans'),
('q_g2_w4_4', 'ch_Spring_2025_w4_g2_Sci', 'Habitat for camel?', 'Desert', 'Ocean', 'Forest'),
('q_g2_w4_5', 'ch_Spring_2025_w4_g2_Sci', 'Bats come out at?', 'Night', 'Day', 'Noon')
ON CONFLICT (id) DO NOTHING;

-- Week 5: Social Studies
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w5_g2_Soc', 'Social Studies', 2) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g2_w5_1', 'ch_Spring_2025_w5_g2_Soc', 'Services are?', 'Things people do', 'Things counting', 'Things eating'),
('q_g2_w5_2', 'ch_Spring_2025_w5_g2_Soc', 'Buyer and Seller?', 'Market', 'School', 'Park'),
('q_g2_w5_3', 'ch_Spring_2025_w5_g2_Soc', 'Rules in a city?', 'Laws', 'Suggestions', 'Games'),
('q_g2_w5_4', 'ch_Spring_2025_w5_g2_Soc', 'Leader of state?', 'Governor', 'Mayor', 'Principal'),
('q_g2_w5_5', 'ch_Spring_2025_w5_g2_Soc', 'Bald Eagle represents?', 'Freedom', 'Anger', 'Sleep')
ON CONFLICT (id) DO NOTHING;


-- ==========================================
-- 3RB GRADE (Grade Level 3)
-- ==========================================

-- Week 1: Math
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w1_g3_Math', 'Math', 3) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g3_w1_1', 'ch_Spring_2025_w1_g3_Math', '3 x 4 = ?', '12', '7', '15'),
('q_g3_w1_2', 'ch_Spring_2025_w1_g3_Math', '15 / 3 = ?', '5', '3', '6'),
('q_g3_w1_3', 'ch_Spring_2025_w1_g3_Math', '300 + 40 + 5?', '345', '3045', '75'),
('q_g3_w1_4', 'ch_Spring_2025_w1_g3_Math', 'Round 47 to nearest 10?', '50', '40', '45'),
('q_g3_w1_5', 'ch_Spring_2025_w1_g3_Math', 'Perimeter of 3x3 square?', '12', '9', '6')
ON CONFLICT (id) DO NOTHING;

-- Week 2: Math
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w2_g3_Math', 'Math', 3) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g3_w2_1', 'ch_Spring_2025_w2_g3_Math', 'Top number of fraction?', 'Numerator', 'Denominator', 'Middle'),
('q_g3_w2_2', 'ch_Spring_2025_w2_g3_Math', '1/2 is equal to?', '2/4', '1/3', '1/5'),
('q_g3_w2_3', 'ch_Spring_2025_w2_g3_Math', 'Area of 4x5 rect?', '20', '9', '18'),
('q_g3_w2_4', 'ch_Spring_2025_w2_g3_Math', '6 x 6 = ?', '36', '32', '42'),
('q_g3_w2_5', 'ch_Spring_2025_w2_g3_Math', '30 mins is?', 'Half hour', 'Quarter hour', 'Hour')
ON CONFLICT (id) DO NOTHING;

-- Week 3: Science
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w3_g3_Sci', 'Science', 3) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g3_w3_1', 'ch_Spring_2025_w3_g3_Sci', 'Forces are?', 'Pushes/Pulls', 'Colors', 'Sounds'),
('q_g3_w3_2', 'ch_Spring_2025_w3_g3_Sci', 'Simple machine?', 'Lever', 'Rock', 'Water'),
('q_g3_w3_3', 'ch_Spring_2025_w3_g3_Sci', 'Earth orbit takes?', '365 days', '24 hours', '1 month'),
('q_g3_w3_4', 'ch_Spring_2025_w3_g3_Sci', 'Moon reflects?', 'Sunlight', 'Earthlight', 'Starlight'),
('q_g3_w3_5', 'ch_Spring_2025_w3_g3_Sci', 'Volcano erupts?', 'Lava', 'Water', 'Ice')
ON CONFLICT (id) DO NOTHING;

-- Week 4: Science
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w4_g3_Sci', 'Science', 3) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g3_w4_1', 'ch_Spring_2025_w4_g3_Sci', 'Adaptation helps?', 'Survive', 'Play', 'Sleep'),
('q_g3_w4_2', 'ch_Spring_2025_w4_g3_Sci', 'Predator eats?', 'Prey', 'Plants', 'Rocks'),
('q_g3_w4_3', 'ch_Spring_2025_w4_g3_Sci', 'Seed travel is?', 'Dispersal', 'Running', 'Flying'),
('q_g3_w4_4', 'ch_Spring_2025_w4_g3_Sci', 'Vertebrates have?', 'Backbones', 'Shells', 'No bones'),
('q_g3_w4_5', 'ch_Spring_2025_w4_g3_Sci', 'Fish breathe with?', 'Gills', 'Lungs', 'Nose')
ON CONFLICT (id) DO NOTHING;

-- Week 5: Social Studies
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w5_g3_Soc', 'Social Studies', 3) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g3_w5_1', 'ch_Spring_2025_w5_g3_Soc', 'Community plan?', 'Map', 'Book', 'Photo'),
('q_g3_w5_2', 'ch_Spring_2025_w5_g3_Soc', 'Government branch?', 'Judicial', 'School', 'Store'),
('q_g3_w5_3', 'ch_Spring_2025_w5_g3_Soc', 'Rights come with?', 'Responsibilities', 'Candy', 'Toys'),
('q_g3_w5_4', 'ch_Spring_2025_w5_g3_Soc', 'National Anthem?', 'Star-Spangled Banner', 'Happy Birthday', 'ABC Song'),
('q_g3_w5_5', 'ch_Spring_2025_w5_g3_Soc', 'Inventors make?', 'New things', 'Old things', 'Food')
ON CONFLICT (id) DO NOTHING;


-- ==========================================
-- 5TH GRADE (Grade Level 5)
-- ==========================================

-- Week 1: Math
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w1_g5_Math', 'Math', 5) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g5_w1_1', 'ch_Spring_2025_w1_g5_Math', '0.5 x 10 = ?', '5', '0.05', '50'),
('q_g5_w1_2', 'ch_Spring_2025_w1_g5_Math', '1/4 + 1/2 = ?', '3/4', '2/6', '1/8'),
('q_g5_w1_3', 'ch_Spring_2025_w1_g5_Math', 'Volume of cube side 3?', '27', '9', '18'),
('q_g5_w1_4', 'ch_Spring_2025_w1_g5_Math', 'Prime number?', '13', '12', '15'),
('q_g5_w1_5', 'ch_Spring_2025_w1_g5_Math', '50 x 20 = ?', '1000', '100', '500')
ON CONFLICT (id) DO NOTHING;

-- Week 2: Math
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w2_g5_Math', 'Math', 5) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g5_w2_1', 'ch_Spring_2025_w2_g5_Math', '100 / 4 = ?', '25', '20', '30'),
('q_g5_w2_2', 'ch_Spring_2025_w2_g5_Math', '0.75 as percent?', '75%', '7.5%', '750%'),
('q_g5_w2_3', 'ch_Spring_2025_w2_g5_Math', 'Order of Ops?', 'PEMDAS', 'PADMES', 'SAMDEP'),
('q_g5_w2_4', 'ch_Spring_2025_w2_g5_Math', 'Coordinate Plane start?', 'Origin (0,0)', 'X-axis', 'Y-axis'),
('q_g5_w2_5', 'ch_Spring_2025_w2_g5_Math', 'Triangle angle sum?', '180', '360', '90')
ON CONFLICT (id) DO NOTHING;

-- Week 3: Science
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w3_g5_Sci', 'Science', 5) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g5_w3_1', 'ch_Spring_2025_w3_g5_Sci', 'Matter State Change?', 'Physical Change', 'Chemical Change', 'Magic'),
('q_g5_w3_2', 'ch_Spring_2025_w3_g5_Sci', 'Light bouncing?', 'Reflection', 'Refraction', 'Absorption'),
('q_g5_w3_3', 'ch_Spring_2025_w3_g5_Sci', 'Mixture solution?', 'Salt Water', 'Salad', 'Trail Mix'),
('q_g5_w3_4', 'ch_Spring_2025_w3_g5_Sci', 'Force resisting motion?', 'Friction', 'Gravity', 'Magnetic'),
('q_g5_w3_5', 'ch_Spring_2025_w3_g5_Sci', 'Conductor of electricity?', 'Copper', 'Rubber', 'Wood')
ON CONFLICT (id) DO NOTHING;

-- Week 4: Science
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w4_g5_Sci', 'Science', 5) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g5_w4_1', 'ch_Spring_2025_w4_g5_Sci', 'Earth Layer?', 'Crust', 'Shell', 'Skin'),
('q_g5_w4_2', 'ch_Spring_2025_w4_g5_Sci', 'Weathering?', 'Breaking Rocks', 'Moving Rocks', 'Dropping Rocks'),
('q_g5_w4_3', 'ch_Spring_2025_w4_g5_Sci', 'Renewable Resource?', 'Solar', 'Coal', 'Oil'),
('q_g5_w4_4', 'ch_Spring_2025_w4_g5_Sci', 'Moon Phase?', 'Full Moon', 'Bright Moon', 'Round Moon'),
('q_g5_w4_5', 'ch_Spring_2025_w4_g5_Sci', 'Decomposer?', 'Fungi', 'Lion', 'Eagle')
ON CONFLICT (id) DO NOTHING;

-- Week 5: Social Studies
INSERT INTO challenges (id, topic, grade_level) VALUES ('ch_Spring_2025_w5_g5_Soc', 'Social Studies', 5) ON CONFLICT (id) DO NOTHING;
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES 
('q_g5_w5_1', 'ch_Spring_2025_w5_g5_Soc', 'Colonists fought?', 'British', 'French', 'Spanish'),
('q_g5_w5_2', 'ch_Spring_2025_w5_g5_Soc', 'Bill of Rights?', 'First 10 Amendments', 'First 5 Laws', 'Declaration'),
('q_g5_w5_3', 'ch_Spring_2025_w5_g5_Soc', 'Civil War North?', 'Union', 'Confederacy', 'Rebels'),
('q_g5_w5_4', 'ch_Spring_2025_w5_g5_Soc', 'Amendment ending slavery?', '13th', '1st', '19th'),
('q_g5_w5_5', 'ch_Spring_2025_w5_g5_Soc', 'Industrial Revolution?', 'Machines', 'Farms', 'Computers')
ON CONFLICT (id) DO NOTHING;
