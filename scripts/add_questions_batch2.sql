-- Batch 2: Grade 0 (Kindergarten) and Grade 1 (1st Grade)
-- Adding 10 new questions per challenge (Total 200 questions)

-- ==========================================
-- GRADE 0: KINDERGARTEN
-- Topics: Math (1-5), Science (6-8), Social (9-10)
-- ==========================================

-- LVL 1 MATH: Numbers to 5
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_1_11', 'gen_0_1', 'Which is the number FIVE?', '5', '3', '2', '4'),
('q_0_1_12', 'gen_0_1', 'How many stars? ⭐⭐⭐', '3', '1', '2', '4'),
('q_0_1_13', 'gen_0_1', 'Which comes after 2?', '3', '1', '4', '5'),
('q_0_1_14', 'gen_0_1', 'How many hearts? 💖💖💖💖', '4', '2', '3', '5'),
('q_0_1_15', 'gen_0_1', 'Find the number 1.', '1', '0', '2', '3'),
('q_0_1_16', 'gen_0_1', 'Count the apples: 🍎🍎', '2', '1', '3', '0'),
('q_0_1_17', 'gen_0_1', 'Which is smaller than 3?', '2', '4', '5', '10'),
('q_0_1_18', 'gen_0_1', 'Count the fingers: 🖐️', '5', '4', '3', '2'),
('q_0_1_19', 'gen_0_1', 'Which comes before 2?', '1', '3', '4', '5'),
('q_0_1_20', 'gen_0_1', 'How many zero? ⭕', '0', '1', '2', '3');

-- LVL 2 MATH: Counting to 10
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_2_11', 'gen_0_2', 'Which number is SEVEN?', '7', '6', '8', '9'),
('q_0_2_12', 'gen_0_2', 'Count the dots: ●●●●●●', '6', '5', '7', '8'),
('q_0_2_13', 'gen_0_2', 'Which number is NINE?', '9', '6', '8', '7'),
('q_0_2_14', 'gen_0_2', 'Count the fish: 🐟🐟🐟🐟🐟🐟🐟🐟', '8', '7', '9', '10'),
('q_0_2_15', 'gen_0_2', 'Which comes after 9?', '10', '8', '7', '11'),
('q_0_2_16', 'gen_0_2', 'Which number is smallest?', '1', '5', '8', '10'),
('q_0_2_17', 'gen_0_2', 'Which number is biggest?', '10', '2', '5', '9'),
('q_0_2_18', 'gen_0_2', 'Count the legs on a spider: 🕷️', '8', '4', '6', '10'),
('q_0_2_19', 'gen_0_2', 'How many fingers on two hands?', '10', '5', '8', '12'),
('q_0_2_20', 'gen_0_2', 'Count the suns: ☀️', '1', '0', '2', '3');

-- LVL 3 MATH: Basic Shapes
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_3_11', 'gen_0_3', 'Which has 3 sides?', 'Triangle', 'Square', 'Circle', 'Oval'),
('q_0_3_12', 'gen_0_3', 'Which is round like a ball?', 'Circle', 'Square', 'Rectangle', 'Triangle'),
('q_0_3_13', 'gen_0_3', 'Which has 4 equal sides?', 'Square', 'Circle', 'Triangle', 'Star'),
('q_0_3_14', 'gen_0_3', 'What shape is a window?', 'Square', 'Circle', 'Oval', 'Crescent'),
('q_0_3_15', 'gen_0_3', 'What shape is a pizza?', 'Circle', 'Square', 'Diamond', 'Rectangle'),
('q_0_3_16', 'gen_0_3', 'What shape is a slice of pizza?', 'Triangle', 'Square', 'Circle', 'Heart'),
('q_0_3_17', 'gen_0_3', 'Which has NO sides?', 'Circle', 'Square', 'Rectangle', 'Triangle'),
('q_0_3_18', 'gen_0_3', 'A box is which shape?', 'Square', 'Circle', 'Triangle', 'Star'),
('q_0_3_19', 'gen_0_3', 'A door is which shape?', 'Rectangle', 'Circle', 'Triangle', 'Heart'),
('q_0_3_20', 'gen_0_3', 'Which shape is a star? ⭐', 'Star', 'Circle', 'Square', 'Diamond');

-- LVL 4 MATH: Addition to 5
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_4_11', 'gen_0_4', '1 + 1 = ?', '2', '1', '3', '4'),
('q_0_4_12', 'gen_0_4', '2 + 1 = ?', '3', '2', '4', '5'),
('q_0_4_13', 'gen_0_4', '3 + 1 = ?', '4', '3', '5', '2'),
('q_0_4_14', 'gen_0_4', '4 + 1 = ?', '5', '4', '3', '6'),
('q_0_4_15', 'gen_0_4', '2 + 2 = ?', '4', '3', '5', '2'),
('q_0_4_16', 'gen_0_4', '1 + 2 = ?', '3', '2', '4', '1'),
('q_0_4_17', 'gen_0_4', '3 + 2 = ?', '5', '4', '6', '3'),
('q_0_4_18', 'gen_0_4', '1 + 0 = ?', '1', '0', '2', '3'),
('q_0_4_19', 'gen_0_4', '0 + 5 = ?', '5', '0', '4', '1'),
('q_0_4_20', 'gen_0_4', '2 + 3 = ?', '5', '4', '3', '2');

-- LVL 5 MATH: Subtraction from 5
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_5_11', 'gen_0_5', '2 - 1 = ?', '1', '2', '0', '3'),
('q_0_5_12', 'gen_0_5', '3 - 1 = ?', '2', '1', '3', '0'),
('q_0_5_13', 'gen_0_5', '4 - 1 = ?', '3', '4', '2', '1'),
('q_0_5_14', 'gen_0_5', '5 - 1 = ?', '4', '5', '3', '2'),
('q_0_5_15', 'gen_0_5', '3 - 2 = ?', '1', '2', '3', '0'),
('q_0_5_16', 'gen_0_5', '4 - 2 = ?', '2', '1', '3', '4'),
('q_0_5_17', 'gen_0_5', '5 - 2 = ?', '3', '2', '4', '5'),
('q_0_5_18', 'gen_0_5', '5 - 5 = ?', '0', '5', '1', '10'),
('q_0_5_19', 'gen_0_5', '4 - 4 = ?', '0', '4', '1', '8'),
('q_0_5_20', 'gen_0_5', '5 - 3 = ?', '2', '3', '1', '4');

-- LVL 6 SCIENCE: Plants & Growing
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_6_11', 'gen_0_6', 'What do plants need to grow?', 'Water and Light', 'Candy', 'Toys', 'Ice'),
('q_0_6_12', 'gen_0_6', 'Which part is under the ground?', 'Roots', 'Leaves', 'Flower', 'Fruit'),
('q_0_6_13', 'gen_0_6', 'Which part is colorful?', 'Flower', 'Stem', 'Roots', 'Dirt'),
('q_0_6_14', 'gen_0_6', 'What grows on a tree?', 'Leaves', 'Shoes', 'Pens', 'Wheels'),
('q_0_6_15', 'gen_0_6', 'Is a tree a plant?', 'Yes', 'No', 'Maybe', 'I don''t know'),
('q_0_6_16', 'gen_0_6', 'What color is grass usually?', 'Green', 'Blue', 'Red', 'Pink'),
('q_0_6_17', 'gen_0_6', 'What do seeds grow into?', 'New plants', 'Rocks', 'Animals', 'Cars'),
('q_0_6_18', 'gen_0_6', 'Where do we plant seeds?', 'Soil', 'Water', 'Sky', 'Bathtub'),
('q_0_6_19', 'gen_0_6', 'Do plants need sunlight?', 'Yes', 'No', 'Only at night', 'Never'),
('q_0_6_20', 'gen_0_6', 'Which is a fruit?', 'Apple', 'Carrot', 'Potato', 'Broccoli');

-- LVL 7 SCIENCE: Animals
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_7_11', 'gen_0_7', 'Who says Bark?', 'Dog', 'Cat', 'Bird', 'Fish'),
('q_0_7_12', 'gen_0_7', 'Which one can fly?', 'Bird', 'Dog', 'Cat', 'Frog'),
('q_0_7_13', 'gen_0_7', 'Who lives in the water?', 'Fish', 'Lion', 'Elephant', 'Horse'),
('q_0_7_14', 'gen_0_7', 'Who has a trunk?', 'Elephant', 'Giraffe', 'Zebra', 'Tiger'),
('q_0_7_15', 'gen_0_7', 'Who says Moo?', 'Cow', 'Pig', 'Duck', 'Sheep'),
('q_0_7_16', 'gen_0_7', 'Who says Quack?', 'Duck', 'Chicken', 'Goat', 'Horse'),
('q_0_7_17', 'gen_0_7', 'Who has feathers?', 'Bird', 'Dog', 'Snake', 'Fish'),
('q_0_7_18', 'gen_0_7', 'Who hop-hop-hops?', 'Rabbit', 'Turtle', 'Snake', 'Worm'),
('q_0_7_19', 'gen_0_7', 'Who is very slow?', 'Turtle', 'Cheetah', 'Horse', 'Rabbit'),
('q_0_7_20', 'gen_0_7', 'Who has a long neck?', 'Giraffe', 'Hippo', 'Bear', 'Monkey');

-- LVL 8 SCIENCE: Weather & Sky
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_8_11', 'gen_0_8', 'What is the big yellow ball in the sky?', 'Sun', 'Moon', 'Cloud', 'Star'),
('q_0_8_12', 'gen_0_8', 'When does it snow?', 'Winter', 'Summer', 'Spring', 'Morning'),
('q_0_8_13', 'gen_0_8', 'What falls when it is rainy?', 'Water', 'Milk', 'Juice', 'Snow'),
('q_0_8_14', 'gen_0_8', 'What do we see at night?', 'Stars', 'Rainbow', 'Sun', 'Clouds'),
('q_0_8_15', 'gen_0_8', 'Which is white and fluffy?', 'Cloud', 'Tree', 'Street', 'Sun'),
('q_0_8_16', 'gen_0_8', 'What makes a rainbow?', 'Sun and Rain', 'Ice', 'Night', 'Wind'),
('q_0_8_17', 'gen_0_8', 'What is the moon shape sometimes?', 'Crescent', 'Square', 'Triangle', 'Heart'),
('q_0_8_18', 'gen_0_8', 'Which season is very hot?', 'Summer', 'Winter', 'Fall', 'Night'),
('q_0_8_19', 'gen_0_8', 'What do we use for rain?', 'Umbrella', 'Towel', 'Pillow', 'Book'),
('q_0_8_20', 'gen_0_8', 'What blows the leaves?', 'Wind', 'Rain', 'Snow', 'Sun');

-- LVL 9 SOCIAL: Community Helpers
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_9_11', 'gen_0_9', 'Who helps when we are sick?', 'Doctor', 'Baker', 'Driver', 'Painter'),
('q_0_9_12', 'gen_0_9', 'Who puts out fires?', 'Firefighter', 'Police Officer', 'Teacher', 'Farmer'),
('q_0_9_13', 'gen_0_9', 'Who teaches us at school?', 'Teacher', 'Pilot', 'Chef', 'Dancer'),
('q_0_9_14', 'gen_0_9', 'Who brings us mail?', 'Mail Carrier', 'Doctor', 'Dentist', 'Librarian'),
('q_0_9_15', 'gen_0_9', 'Who grows food on a farm?', 'Farmer', 'Scientist', 'Actor', 'Singer'),
('q_0_9_16', 'gen_0_9', 'Who flies a plane?', 'Pilot', 'Bus Driver', 'Captain', 'Astronaut'),
('q_0_9_17', 'gen_0_9', 'Who helps our teeth?', 'Dentist', 'Nurse', 'Baker', 'Clown'),
('q_0_9_18', 'gen_0_9', 'Who cooks food at a restaurant?', 'Chef', 'Mechanic', 'Artist', 'Judge'),
('q_0_9_19', 'gen_0_9', 'Who keeps us safe?', 'Police Officer', 'Magician', 'Musician', 'Athlete'),
('q_0_9_20', 'gen_0_9', 'Who travels into space?', 'Astronaut', 'Driver', 'Farmer', 'Baker');

-- LVL 10 SOCIAL: Friends & Feelings
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_0_10_11', 'gen_0_10', 'How do you feel when you smile?', 'Happy', 'Sad', 'Angry', 'Scared'),
('q_0_10_12', 'gen_0_10', 'What do we do with toys?', 'Share', 'Throw', 'Hide', 'Break'),
('q_0_10_13', 'gen_0_10', 'How do you feel when you cry?', 'Sad', 'Happy', 'Excited', 'Silky'),
('q_0_10_14', 'gen_0_10', 'How do we treat our friends?', 'Kindly', 'Meanly', 'Roughly', 'Never'),
('q_0_10_15', 'gen_0_10', 'Are you a good friend?', 'Yes', 'No', 'Maybe', 'Sometimes'),
('q_0_10_16', 'gen_0_10', 'What should we say after hurting someone?', 'I am sorry', 'Go away', 'I don''t care', 'Laugh'),
('q_0_10_17', 'gen_0_10', 'What do we say when someone helps us?', 'Thank you', 'No', 'Goodbye', 'Please'),
('q_0_10_18', 'gen_0_10', 'What do we do when we want a toy?', 'Ask nicely', 'Grab it', 'Scream', 'Cry'),
('q_0_10_19', 'gen_0_10', 'Is it okay to be angry?', 'Yes (but be safe)', 'No', 'Always', 'Never'),
('q_0_10_20', 'gen_0_10', 'Who can help if you are sad?', 'Grown-ups', 'Pet rock', 'A ghost', 'No one');

-- ==========================================
-- GRADE 1: 1ST GRADE
-- Topics: Math (1-5), Science (6-8), Social (9-10)
-- ==========================================

-- LVL 1 MATH: Addition to 10
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_1_11', 'gen_1_1', '5 + 5 = ?', '10', '9', '11', '12'),
('q_1_1_12', 'gen_1_1', '6 + 2 = ?', '8', '7', '9', '10'),
('q_1_1_13', 'gen_1_1', '3 + 4 = ?', '7', '6', '8', '5'),
('q_1_1_14', 'gen_1_1', '7 + 3 = ?', '10', '9', '11', '8'),
('q_1_1_15', 'gen_1_1', '2 + 5 = ?', '7', '6', '8', '9'),
('q_1_1_16', 'gen_1_1', '1 + 9 = ?', '10', '8', '11', '9'),
('q_1_1_17', 'gen_1_1', '4 + 4 = ?', '8', '7', '9', '6'),
('q_1_1_18', 'gen_1_1', '8 + 1 = ?', '9', '8', '10', '7'),
('q_1_1_19', 'gen_1_1', '2 + 2 = ?', '4', '3', '5', '6'),
('q_1_1_20', 'gen_1_1', '5 + 3 = ?', '8', '7', '9', '10');

-- LVL 2 MATH: Subtraction from 10
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_2_11', 'gen_1_2', '10 - 5 = ?', '5', '4', '6', '7'),
('q_1_2_12', 'gen_1_2', '8 - 3 = ?', '5', '4', '6', '3'),
('q_1_2_13', 'gen_1_2', '9 - 4 = ?', '5', '4', '6', '7'),
('q_1_2_14', 'gen_1_2', '7 - 2 = ?', '5', '4', '6', '3'),
('q_1_2_15', 'gen_1_2', '10 - 2 = ?', '8', '7', '9', '6'),
('q_1_2_16', 'gen_1_2', '6 - 3 = ?', '3', '2', '4', '1'),
('q_1_2_17', 'gen_1_2', '5 - 5 = ?', '0', '1', '10', '5'),
('q_1_2_18', 'gen_1_2', '9 - 1 = ?', '8', '7', '9', '10'),
('q_1_2_19', 'gen_1_2', '8 - 8 = ?', '0', '8', '1', '16'),
('q_1_2_20', 'gen_1_2', '10 - 9 = ?', '1', '0', '2', '10');

-- LVL 3 MATH: Tens & Ones
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_3_11', 'gen_1_3', 'What is 10 + 3?', '13', '103', '31', '30'),
('q_1_3_12', 'gen_1_3', '1 ten and 2 ones is?', '12', '21', '102', '3'),
('q_1_3_13', 'gen_1_3', 'What is 10 + 7?', '17', '107', '71', '70'),
('q_1_3_14', 'gen_1_3', '2 tens is?', '20', '2', '200', '10'),
('q_1_3_15', 'gen_1_3', '1 ten and 5 ones is?', '15', '51', '105', '6'),
('q_1_3_16', 'gen_1_3', 'What is 10 plus 10?', '20', '1010', '100', '11'),
('q_1_3_17', 'gen_1_3', '1 ten and 0 ones is?', '10', '1', '100', '0'),
('q_1_3_18', 'gen_1_3', 'What is 18?', '1 ten, 8 ones', '8 tens, 1 one', '18 tens', '9+9'),
('q_1_3_19', 'gen_1_3', 'What is 11?', '1 ten, 1 one', '2 tens', '11 tens', '1+1'),
('q_1_3_20', 'gen_1_3', '1 ten and 4 ones is?', '14', '41', '104', '5');

-- LVL 4 MATH: Time & Money
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_4_11', 'gen_1_4', 'A penny is worth?', '1 cent', '5 cents', '10 cents', '25 cents'),
('q_1_4_12', 'gen_1_4', 'A nickel is worth?', '5 cents', '1 cent', '10 cents', '25 cents'),
('q_1_4_13', 'gen_1_4', 'A dime is worth?', '10 cents', '1 cent', '5 cents', '25 cents'),
('q_1_4_14', 'gen_1_4', 'A quarter is worth?', '25 cents', '10 cents', '5 cents', '50 cents'),
('q_1_4_15', 'gen_1_4', 'What has 12 numbers?', 'Clock', 'Penny', 'Nickel', 'Dime'),
('q_1_4_16', 'gen_1_4', '3:00 is three?', 'O''clock', 'Seconds', 'Minutes', 'Months'),
('q_1_4_17', 'gen_1_4', 'Small hand on a clock shows?', 'Hour', 'Minute', 'Second', 'Day'),
('q_1_4_18', 'gen_1_4', 'Big hand on a clock shows?', 'Minute', 'Hour', 'Second', 'Month'),
('q_1_4_19', 'gen_1_4', 'How many cents in 2 nickels?', '10', '5', '2', '20'),
('q_1_4_20', 'gen_1_4', 'Which coin is largest in size?', 'Quarter', 'Dime', 'Penny', 'Nickel');

-- LVL 5 MATH: Measurements
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_5_11', 'gen_1_5', 'Which is heavier?', 'Elephant', 'Mouse', 'Bird', 'Snail'),
('q_1_5_12', 'gen_1_5', 'Which is longer?', 'Snake', 'Worm', 'Ant', 'Bee'),
('q_1_5_13', 'gen_1_5', 'Which is taller?', 'Giraffe', 'Zebra', 'Horse', 'Sheep'),
('q_1_5_14', 'gen_1_5', 'What do we use to measure length?', 'Ruler', 'Scale', 'Clock', 'Compass'),
('q_1_5_15', 'gen_1_5', 'How many inches usually in a big ruler?', '12', '6', '24', '1'),
('q_1_5_16', 'gen_1_5', 'Which is lighter?', 'Feather', 'Rock', 'Brick', 'Car'),
('q_1_5_17', 'gen_1_5', 'A gallon is a measure of?', 'Liquid', 'Weight', 'Length', 'Time'),
('q_1_5_18', 'gen_1_5', 'Which holds MORE water?', 'Bucket', 'Cup', 'Spoon', 'Drop'),
('q_1_5_19', 'gen_1_5', 'Which holds LESS water?', 'Spoon', 'Bathtub', 'Pool', 'Jug'),
('q_1_5_20', 'gen_1_5', 'A scale measures?', 'Weight', 'Length', 'Time', 'Money');

-- LVL 6 SCIENCE: The Five Senses
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_6_11', 'gen_1_6', 'Which sense uses your ears?', 'Hearing', 'Seeing', 'Smelling', 'Tasting'),
('q_1_6_12', 'gen_1_6', 'Which sense uses your nose?', 'Smelling', 'Hearing', 'Touching', 'Tasting'),
('q_1_6_13', 'gen_1_6', 'Which sense uses your skin?', 'Touching', 'Seeing', 'Smelling', 'Hearing'),
('q_1_6_14', 'gen_1_6', 'What color can you SEE?', 'Blue', 'Quiet', 'Loud', 'Salty'),
('q_1_6_15', 'gen_1_6', 'Which sense uses your tongue?', 'Tasting', 'Touching', 'Hearing', 'Seeing'),
('q_1_6_16', 'gen_1_6', 'What is a SOUR taste?', 'Lemon', 'Sugar', 'Bread', 'Water'),
('q_1_6_17', 'gen_1_6', 'What is a LOUD sound?', 'Thunder', 'Whisper', 'Snow', 'Feather'),
('q_1_6_18', 'gen_1_6', 'Which sense helps you read?', 'Seeing', 'Hearing', 'Tasting', 'Smelling'),
('q_1_6_19', 'gen_1_6', 'Soft is a feeling of?', 'Touch', 'Sight', 'Sound', 'Smell'),
('q_1_6_20', 'gen_1_6', 'Which sense warns you of smoke?', 'Smelling', 'Tasting', 'Seeing', 'Touching');

-- LVL 7 SCIENCE: Animals & Life Cycles
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_7_11', 'gen_1_7', 'What does a caterpillar change into?', 'Butterfly', 'Bee', 'Ant', 'Moth'),
('q_1_7_12', 'gen_1_7', 'A baby frog is called a?', 'Tadpole', 'Puppy', 'Kitten', 'Chick'),
('q_1_7_13', 'gen_1_7', 'Birds hatch from?', 'Eggs', 'Seeds', 'Water', 'Boxes'),
('q_1_7_14', 'gen_1_7', 'Where does a fish live?', 'Water', 'Tree', 'Desert', 'Space'),
('q_1_7_15', 'gen_1_7', 'A mammal has?', 'Fur or Hair', 'Feathers', 'Scales', 'Shells'),
('q_1_7_16', 'gen_1_7', 'Which animal lives in a den?', 'Bear', 'Fish', 'Bird', 'Whale'),
('q_1_7_17', 'gen_1_7', 'What do herbivores eat?', 'Plants', 'Meat', 'Rocks', 'Paper'),
('q_1_7_18', 'gen_1_7', 'What do carnivores eat?', 'Meat', 'Grass', 'Flowers', 'Fruit'),
('q_1_7_19', 'gen_1_7', 'A spider has how many legs?', '8', '6', '4', '10'),
('q_1_7_20', 'gen_1_7', 'Which animal hatches from an egg?', 'Turtle', 'Cow', 'Horse', 'Dog');

-- LVL 8 SCIENCE: Earth & Seasons
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_8_11', 'gen_1_8', 'In which season do leaves fall?', 'Fall', 'Spring', 'Summer', 'Winter'),
('q_1_8_12', 'gen_1_8', 'Which planet do we live on?', 'Earth', 'Mars', 'Jupiter', 'The Moon'),
('q_1_8_13', 'gen_1_8', 'In which season is it very cold?', 'Winter', 'Summer', 'Spring', 'Fall'),
('q_1_8_14', 'gen_1_8', 'In which season do plants bloom?', 'Spring', 'Fall', 'Winter', 'Night'),
('q_1_8_15', 'gen_1_8', 'How many seasons are there?', '4', '2', '3', '12'),
('q_1_8_16', 'gen_1_8', 'The sun is a?', 'Star', 'Planet', 'Moon', 'Cloud'),
('q_1_8_17', 'gen_1_8', 'Where does the sun go at night?', 'Other side of Earth', 'Dies', 'Sleeps', 'Space'),
('q_1_8_18', 'gen_1_8', 'What is the largest ocean creature?', 'Blue Whale', 'Shark', 'Dolphin', 'Goldfish'),
('q_1_8_19', 'gen_1_8', 'What is a giant pile of ice?', 'Glacier', 'Cloud', 'Mountain', 'Hill'),
('q_1_8_20', 'gen_1_8', 'Which star is closest to Earth?', 'The Sun', 'Polaris', 'Sirius', 'Moon');

-- LVL 9 SOCIAL: Community
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_9_11', 'gen_1_9', 'Who helps us learn?', 'Teacher', 'Baker', 'Clown', 'Farmer'),
('q_1_9_12', 'gen_1_9', 'What do we use to buy things?', 'Money', 'Leaves', 'Rocks', 'Candy'),
('q_1_9_13', 'gen_1_9', 'Who protects the community?', 'Police Officer', 'Scientist', 'Artist', 'Chef'),
('q_1_9_14', 'gen_1_9', 'Where do we go to borrow books?', 'Library', 'Bakery', 'Park', 'Gym'),
('q_1_9_15', 'gen_1_9', 'Which is a rule at school?', 'Be Kind', 'Run inside', 'Yell loud', 'Hide'),
('q_1_9_16', 'gen_1_9', 'Who helps when there is a fire?', 'Firefighter', 'Dentist', 'Mail Carrier', 'Pilot'),
('q_1_9_17', 'gen_1_9', 'Our country''s flag is?', 'Red, White, Blue', 'Green and Yellow', 'Purple', 'Orange'),
('q_1_9_18', 'gen_1_9', 'Who is the leader of a city?', 'Mayor', 'President', 'King', 'Principal'),
('q_1_9_19', 'gen_1_9', 'What is a map used for?', 'Finding places', 'Eating', 'Sleeping', 'Drawing'),
('q_1_9_20', 'gen_1_9', 'Where do we go to play outside?', 'Park', 'Classroom', 'Kitchen', 'Garage');

-- LVL 10 SOCIAL: History & Symbols
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_1_10_11', 'gen_1_10', 'Who was the first President?', 'George Washington', 'Abraham Lincoln', 'Martin Luther King', 'Ernie'),
('q_1_10_12', 'gen_1_10', 'Our national bird is?', 'Bald Eagle', 'Penguin', 'Parrot', 'Duck'),
('q_1_10_13', 'gen_1_10', 'Where does the President live?', 'White House', 'Tree House', 'School', 'Library'),
('q_1_10_14', 'gen_1_10', 'Which holiday is in December?', 'Christmas', 'Halloween', 'Easter', 'July 4th'),
('q_1_10_15', 'gen_1_10', 'What do we celebrate on July 4th?', 'Independence Day', 'My Birthday', 'Halloween', 'Winter'),
('q_1_10_16', 'gen_1_10', 'Who helped change laws for fairness?', 'MLK Jr.', 'George Washington', 'A pirate', 'Ernie'),
('q_1_10_17', 'gen_1_10', 'The statue that shows freedom?', 'Statue of Liberty', 'Big Ben', 'Eiffel Tower', 'Pyramids'),
('q_1_10_18', 'gen_1_10', 'What shows the 50 states?', '50 Stars', '50 Stripes', '50 Circles', '50 Birds'),
('q_1_10_19', 'gen_1_10', 'What is the Liberty Bell symbol?', 'Freedom', 'Lunch', 'Music', 'School'),
('q_1_10_20', 'gen_1_10', 'Who wrote the Star Spangled Banner?', 'Francis Scott Key', 'Ernie', 'George Washington', 'Lincoln');
