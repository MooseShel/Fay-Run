-- Fay Gator Run - Grade-Level Topic-Specific Exams
-- This script creates 32 sample exams across 8 grades (Pre-K to 5th Grade)
-- Subjects: Math, Science, Social Studies, English (ELA)
-- Each exam contains 10 questions.

-- ==========================================
-- GRADE -2: PRE-K (3 YEAR OLDS)
-- ==========================================

INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name) VALUES
('exam_neg2_math', 'Math', -2, 1, TRUE, 'PK3 Math Basics'),
('exam_neg2_science', 'Science', -2, 1, TRUE, 'PK3 Nature Explorer'),
('exam_neg2_social', 'Social Studies', -2, 1, TRUE, 'PK3 My Family'),
('exam_neg2_english', 'English', -2, 1, TRUE, 'PK3 Letter Fun');

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
-- Math PK3
('q_ex_n2_m1', 'exam_neg2_math', 'How many ducks? 🦆🦆', '2', '1', '3', '4'),
('q_ex_n2_m2', 'exam_neg2_math', 'Find the Circle!', '🔴', '🟦', '🔺', '⭐'),
('q_ex_n2_m3', 'exam_neg2_math', 'Which number is ONE?', '1', '2', '3', '0'),
('q_ex_n2_m4', 'exam_neg2_math', 'Touch the square!', '🟦', '🔴', '🔺', '🌙'),
('q_ex_n2_m5', 'exam_neg2_math', 'How many? 🍎', '1', '2', '3', '0'),
('q_ex_n2_m6', 'exam_neg2_math', 'Find the triangle!', '🔺', '🔴', '🟦', '🟠'),
('q_ex_n2_m7', 'exam_neg2_math', 'Touch the number 3.', '3', '1', '2', '5'),
('q_ex_n2_m8', 'exam_neg2_math', 'Which is BIG?', '🐘', '🐭', '🐜', '🐝'),
('q_ex_n2_m9', 'exam_neg2_math', 'How many fish? 🐟🐟🐟', '3', '1', '2', '0'),
('q_ex_n2_m10', 'exam_neg2_math', 'Touch the number 2.', '2', '1', '3', '4'),
-- Science PK3
('q_ex_n2_s1', 'exam_neg2_science', 'What animal says Meow?', '🐱', '🐶', '🐮', '🐷'),
('q_ex_n2_s2', 'exam_neg2_science', 'Where do fish live?', 'Water', 'Tree', 'Sky', 'Desert'),
('q_ex_n2_s3', 'exam_neg2_science', 'What color is grass?', 'Green', 'Red', 'Blue', 'Pink'),
('q_ex_n2_s4', 'exam_neg2_science', 'Who says Moo?', '🐮', '🐑', '🐔', '🐴'),
('q_ex_n2_s5', 'exam_neg2_science', 'Find the flower!', '🌻', '🪨', '🚗', '🏠'),
('q_ex_n2_s6', 'exam_neg2_science', 'What is HOT?', '🔥', '🍦', '🧊', '⛄'),
('q_ex_n2_s7', 'exam_neg2_science', 'Who can fly?', '🐦', '🐕', '🐢', '🐊'),
('q_ex_n2_s8', 'exam_neg2_science', 'What is COLD?', '❄️', '🔥', '☀️', '🌋'),
('q_ex_n2_s9', 'exam_neg2_science', 'Find the tree!', '🌳', '🚲', '🪁', '🏐'),
('q_ex_n2_s10', 'exam_neg2_science', 'Who has a long trunk?', '🐘', '🦒', '🦓', '🐅'),
-- Social PK3
('q_ex_n2_so1', 'exam_neg2_social', 'Where do we sleep?', '🛏️', '🥣', '🌳', '🚗'),
('q_ex_n2_so2', 'exam_neg2_social', 'Who takes care of us?', 'Family', 'Dinosaurs', 'Bees', 'Ants'),
('q_ex_n2_so3', 'exam_neg2_social', 'Touch the house!', '🏠', '🧁', '🎈', '🖍️'),
('q_ex_n2_so4', 'exam_neg2_social', 'Find the baby!', '👶', '👴', '🏢', '🚲'),
('q_ex_n2_so5', 'exam_neg2_social', 'Where do we sit?', '🪑', '🚿', '🚪', '🪜'),
('q_ex_n2_so6', 'exam_neg2_social', 'Where do we cook?', 'Kitchen', 'Bath', 'Bed', 'Yard'),
('q_ex_n2_so7', 'exam_neg2_social', 'Who helps us at school?', 'Teacher', 'Tiger', 'Lion', 'Bear'),
('q_ex_n2_so8', 'exam_neg2_social', 'How do we treat friends?', 'Kindly', 'Meanly', 'Roughly', 'No'),
('q_ex_n2_so9', 'exam_neg2_social', 'Touch the door!', '🚪', '☁️', '🌳', '👟'),
('q_ex_n2_so10', 'exam_neg2_social', 'Where do we play?', 'Playground', 'In the soup', 'On the bed', 'Bath'),
-- English PK3
('q_ex_n2_e1', 'exam_neg2_english', 'Find the letter A.', 'A', 'B', 'C', 'D'),
('q_ex_n2_e2', 'exam_neg2_english', 'What is the first letter?', 'A', 'Z', 'M', 'P'),
('q_ex_n2_e3', 'exam_neg2_english', 'Find the letter B.', 'B', 'A', 'C', 'D'),
('q_ex_n2_e4', 'exam_neg2_english', 'What letter is for Apple?', 'A', 'B', 'C', 'D'),
('q_ex_n2_e5', 'exam_neg2_english', 'Find the letter C.', 'C', 'A', 'B', 'D'),
('q_ex_n2_e6', 'exam_neg2_english', 'What letter is for Ball?', 'B', 'A', 'C', 'D'),
('q_ex_n2_e7', 'exam_neg2_english', 'Find the letter D.', 'D', 'A', 'B', 'C'),
('q_ex_n2_e8', 'exam_neg2_english', 'What letter is for Cat?', 'C', 'A', 'B', 'D'),
('q_ex_n2_e9', 'exam_neg2_english', 'Find the letter E.', 'E', 'A', 'B', 'C'),
('q_ex_n2_e10', 'exam_neg2_english', 'What letter is for Dog?', 'D', 'A', 'B', 'C');

-- ==========================================
-- GRADE -1: PRE-K (4 YEAR OLDS)
-- ==========================================

INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name) VALUES
('exam_neg1_math', 'Math', -1, 1, TRUE, 'PK4 Math Skills'),
('exam_neg1_science', 'Science', -1, 1, TRUE, 'PK4 Weather & Life'),
('exam_neg1_social', 'Social Studies', -1, 1, TRUE, 'PK4 My Community'),
('exam_neg1_english', 'English', -1, 1, TRUE, 'PK4 Reading Prep');

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
-- Math PK4
('q_ex_n1_m1', 'exam_neg1_math', 'Count the stars: ⭐⭐⭐⭐⭐', '5', '4', '6', '3'),
('q_ex_n1_m2', 'exam_neg1_math', 'Which number is TEN?', '10', '1', '0', '100'),
('q_ex_n1_m3', 'exam_neg1_math', 'How many hearts? 💖💖', '2', '1', '3', '0'),
('q_ex_n1_m4', 'exam_neg1_math', 'What comes after 1?', '2', '0', '3', '4'),
('q_ex_n1_m5', 'exam_neg1_math', 'How many moons? 🌙🌙🌙', '3', '2', '4', '1'),
('q_ex_n1_m6', 'exam_neg1_math', 'Which is SMALL?', '🐜', '🐘', '🏠', '🚌'),
('q_ex_n1_m7', 'exam_neg1_math', 'Count to 4: 1, 2, 3, ?', '4', '5', '0', '6'),
('q_ex_n1_m8', 'exam_neg1_math', 'Which has NO sides?', 'Circle', 'Square', 'Triangle', 'Box'),
('q_ex_n1_m9', 'exam_neg1_math', 'How many? 🖐️', '5', '1', '10', '2'),
('q_ex_n1_m10', 'exam_neg1_math', 'What comes before 2?', '1', '3', '0', '4'),
-- Science PK4
('q_ex_n1_s1', 'exam_neg1_science', 'What falls when it is snowy?', 'Snow', 'Rain', 'Milk', 'Candy'),
('q_ex_n1_s2', 'exam_neg1_science', 'What does a caterpillar become?', 'Butterfly', 'Spider', 'Ant', 'Bee'),
('q_ex_n1_s3', 'exam_neg1_science', 'Which is in the night sky?', 'Moon', 'Sun', 'Rainbow', 'Bus'),
('q_ex_n1_s4', 'exam_neg1_science', 'What part of a plant is in the soil?', 'Roots', 'Flower', 'Stem', 'Leaves'),
('q_ex_n1_s5', 'exam_neg1_science', 'What is VERY cold?', 'Ice', 'Fire', 'Sun', 'Soup'),
('q_ex_n1_s6', 'exam_neg1_science', 'Who hatches from an egg?', 'Chick', 'Puppy', 'Kitten', 'Pig'),
('q_ex_n1_s7', 'exam_neg1_science', 'What makes the trees move?', 'Wind', 'Sun', 'Cloud', 'Dirt'),
('q_ex_n1_s8', 'exam_neg1_science', 'A tadpole grows into a?', 'Frog', 'Dog', 'Cat', 'Bird'),
('q_ex_n1_s9', 'exam_neg1_science', 'What do we use to see?', 'Eyes', 'Ears', 'Nose', 'Feet'),
('q_ex_n1_s10', 'exam_neg1_science', 'What does a seed grow into?', 'Plant', 'Rock', 'Car', 'House'),
-- Social PK4
('q_ex_n1_so1', 'exam_neg1_social', 'Who helps when we are sick?', 'Doctor', 'Baker', 'Painter', 'Clown'),
('q_ex_n1_so2', 'exam_neg1_social', 'Who teaches us at school?', 'Teacher', 'Farmer', 'Pilot', 'Chef'),
('q_ex_n1_so3', 'exam_neg1_social', 'Where do we go to learn?', 'School', 'Park', 'Beach', 'Store'),
('q_ex_n1_so4', 'exam_neg1_social', 'Who brings us mail?', 'Mail Carrier', 'Firefighter', 'Dentist', 'Artist'),
('q_ex_n1_so5', 'exam_neg1_social', 'Which one is a community?', 'Where we live', 'A solo toy', 'A rock', 'The moon'),
('q_ex_n1_so6', 'exam_neg1_social', 'Who puts out fires?', 'Firefighter', 'Police', 'Doctor', 'Baker'),
('q_ex_n1_so7', 'exam_neg1_social', 'Where do we buy food?', 'Store', 'School', 'Library', 'Bed'),
('q_ex_n1_so8', 'exam_neg1_social', 'How do we say please?', 'Nicely', 'Meanly', 'Screaming', 'Quietly'),
('q_ex_n1_so9', 'exam_neg1_social', 'Who grows food?', 'Farmer', 'Lawyer', 'Astronaut', 'Singer'),
('q_ex_n1_so10', 'exam_neg1_social', 'Who keeps our teeth healthy?', 'Dentist', 'Chef', 'Pilot', 'Bus Driver'),
-- English PK4
('q_ex_n1_e1', 'exam_neg1_english', 'Which one rhymes with Cat?', 'Hat', 'Dog', 'Sun', 'Boy'),
('q_ex_n1_e2', 'exam_neg1_english', 'What letter is for Elephant?', 'E', 'A', 'B', 'M'),
('q_ex_n1_e3', 'exam_neg1_english', 'What color is RED?', '🍎', '🍌', '🥦', '🫐'),
('q_ex_n1_e4', 'exam_neg1_english', 'Which letter is last?', 'Z', 'A', 'B', 'C'),
('q_ex_n1_e5', 'exam_neg1_english', 'What rhymes with Dog?', 'Log', 'Cat', 'Car', 'Hat'),
('q_ex_n1_e6', 'exam_neg1_english', 'Find the letter M.', 'M', 'W', 'N', 'V'),
('q_ex_n1_e7', 'exam_neg1_english', 'What is for Sun?', 'S', 'A', 'P', 'R'),
('q_ex_n1_e8', 'exam_neg1_english', 'What rhymes with Pie?', 'Sky', 'Eat', 'Box', 'Pen'),
('q_ex_n1_e9', 'exam_neg1_english', 'What letter starts Apple?', 'A', 'B', 'Z', 'S'),
('q_ex_n1_e10', 'exam_neg1_english', 'What letter is for Zebras?', 'Z', 'A', 'S', 'B');

-- ==========================================
-- GRADE 0: KINDERGARTEN
-- ==========================================

INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name) VALUES
('exam_0_math', 'Math', 0, 1, TRUE, 'K Addition Exam'),
('exam_0_science', 'Science', 0, 1, TRUE, 'K Earth & Sky Exam'),
('exam_0_social', 'Social Studies', 0, 1, TRUE, 'K Community Exam'),
('exam_0_english', 'English', 0, 1, TRUE, 'K Sight Words Exam');

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
-- Math K
('q_ex_0_m1', 'exam_0_math', '1 + 1 = ?', '2', '1', '3', '0'),
('q_ex_0_m2', 'exam_0_math', '2 + 1 = ?', '3', '2', '4', '1'),
('q_ex_0_m3', 'exam_0_math', 'What is 5 - 1?', '4', '5', '3', '6'),
('q_ex_0_m4', 'exam_0_math', 'Count the circles: 🔴🔴🔴', '3', '1', '2', '4'),
('q_ex_0_m5', 'exam_0_math', '3 + 2 = ?', '5', '4', '6', '1'),
('q_ex_0_m6', 'exam_0_math', 'What is 4 - 2?', '2', '3', '4', '1'),
('q_ex_0_m7', 'exam_0_math', '0 + 4 = ?', '4', '0', '1', '5'),
('q_ex_0_m8', 'exam_0_math', 'What is 2 + 2?', '4', '2', '3', '5'),
('q_ex_0_m9', 'exam_0_math', '1 + 4 = ?', '5', '4', '6', '3'),
('q_ex_0_m10', 'exam_0_math', 'Subtract 5 - 0?', '5', '0', '4', '1'),
-- Science K
('q_ex_0_s1', 'exam_0_science', 'What do plants need to grow?', 'Water and Light', 'Candy', 'Toys', 'Ice'),
('q_ex_0_s2', 'exam_0_science', 'What is the big yellow ball in the sky?', 'Sun', 'Moon', 'Cloud', 'Star'),
('q_ex_0_s3', 'exam_0_science', 'Where do fish breathe?', 'Under water', 'In trees', 'In space', 'In a box'),
('q_ex_0_s4', 'exam_0_science', 'What color are most leaves?', 'Green', 'Red', 'Blue', 'Pink'),
('q_ex_0_s5', 'exam_0_science', 'What season is very hot?', 'Summer', 'Winter', 'Morning', 'Night'),
('q_ex_0_s6', 'exam_0_science', 'What comes from clouds when it rains?', 'Water', 'Milk', 'Juice', 'Snow'),
('q_ex_0_s7', 'exam_0_science', 'What sound does a cow make?', 'Moo', 'Bark', 'Meow', 'Quack'),
('q_ex_0_s8', 'exam_0_science', 'What do we use to hear?', 'Ears', 'Eyes', 'Nose', 'Hands'),
('q_ex_0_s9', 'exam_0_science', 'What is a baby dog called?', 'Puppy', 'Kitten', 'Chick', 'Tadpole'),
('q_ex_0_s10', 'exam_0_science', 'Which one is white and fluffy?', 'Cloud', 'Dirt', 'Stone', 'Coal'),
-- Social K
('q_ex_0_so1', 'exam_0_social', 'Who is in our family?', 'Mom, Dad, Siblings', 'A dinosaur', 'A robot', 'A bug'),
('q_ex_0_so2', 'exam_0_social', 'Who keeps us safe?', 'Police Officer', 'Alien', 'Monster', 'Ghost'),
('q_ex_0_so3', 'exam_0_social', 'What do we say when someone helps?', 'Thank you', 'No', 'Goodbye', 'Go away'),
('q_ex_0_so4', 'exam_0_social', 'What do we do with our toys?', 'Share them', 'Break them', 'Hide them', 'Throw them'),
('q_ex_0_so5', 'exam_0_social', 'Where do we go for school?', 'Classroom', 'Garden', 'Playground', 'Bed'),
('q_ex_0_so6', 'exam_0_social', 'Who is the leader of a class?', 'Teacher', 'Student', 'Principal', 'Janitor'),
('q_ex_0_so7', 'exam_0_social', 'How do we feel when we smile?', 'Happy', 'Sad', 'Angry', 'Scared'),
('q_ex_0_so8', 'exam_0_social', 'What is a rule at school?', 'Be Kind', 'Run inside', 'Scream', 'Litter'),
('q_ex_0_so9', 'exam_0_social', 'Who helps the sick?', 'Nurse or Doctor', 'Baker', 'Clown', 'Farmer'),
('q_ex_0_so10', 'exam_0_social', 'What do we say before getting cookie?', 'Please', 'Now!', 'No', 'I want it'),
-- English K
('q_ex_0_e1', 'exam_0_english', 'Which word is "THE"?', 'The', 'And', 'Bit', 'Cat'),
('q_ex_0_e2', 'exam_0_english', 'Read this word: CAT', 'Cat', 'Car', 'Can', 'Cup'),
('q_ex_0_e3', 'exam_0_english', 'Which word is "AND"?', 'And', 'For', 'You', 'The'),
('q_ex_0_e4', 'exam_0_english', 'Read this word: DOG', 'Dog', 'Dot', 'Dig', 'Duck'),
('q_ex_0_e5', 'exam_0_english', 'Which word is "SEE"?', 'See', 'Saw', 'Sun', 'Sat'),
('q_ex_0_e6', 'exam_0_english', 'How many letters in "CAN"?', '3', '2', '4', '1'),
('q_ex_0_e7', 'exam_0_english', 'Which word stays for "YOU"?', 'You', 'Me', 'Up', 'Down'),
('q_ex_0_e8', 'exam_0_english', 'Which word is "BIG"?', 'Big', 'Bag', 'Bug', 'Bin'),
('q_ex_0_e9', 'exam_0_english', 'Read this word: RUN', 'Run', 'Rat', 'Red', 'Rug'),
('q_ex_0_e10', 'exam_0_english', 'Which is the word "LITTLE"?', 'Little', 'Big', 'Small', 'Short');

-- ==========================================
-- GRADE 1: 1ST GRADE
-- ==========================================

INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name) VALUES
('exam_1_math', 'Math', 1, 1, TRUE, 'Grade 1 Math Exam'),
('exam_1_science', 'Science', 1, 1, TRUE, 'Grade 1 Senses Exam'),
('exam_1_social', 'Social Studies', 1, 1, TRUE, 'Grade 1 History Exam'),
('exam_1_english', 'English', 1, 1, TRUE, 'Grade 1 ELA Exam');

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
-- Math 1
('q_ex_1_m1', 'exam_1_math', '5 + 4 = ?', '9', '8', '10', '7'),
('q_ex_1_m2', 'exam_1_math', '10 - 3 = ?', '7', '6', '8', '5'),
('q_ex_1_m3', 'exam_1_math', '1 ten and 2 ones is?', '12', '21', '102', '3'),
('q_ex_1_m4', 'exam_1_math', 'What is 8 + 3?', '11', '10', '12', '9'),
('q_ex_1_m5', 'exam_1_math', 'Half of 10 is?', '5', '2', '4', '6'),
('q_ex_1_m6', 'exam_1_math', 'A nickel is worth?', '5 cents', '1 cent', '10 cents', '25 cents'),
('q_ex_1_m7', 'exam_1_math', 'How many tens in 20?', '2', '1', '10', '0'),
('q_ex_1_m8', 'exam_1_math', 'What comes after 19?', '20', '18', '21', '10'),
('q_ex_1_m9', 'exam_1_math', '4 + 6 = ?', '10', '9', '11', '12'),
('q_ex_1_m10', 'exam_1_math', 'What is 10 + 10?', '20', '10', '100', '11'),
-- Science 1
('q_ex_1_s1', 'exam_1_science', 'Which sense uses your ears?', 'Hearing', 'Seeing', 'Smelling', 'Tasting'),
('q_ex_1_s2', 'exam_1_science', 'Which sense uses your nose?', 'Smelling', 'Tasting', 'Seeing', 'Touching'),
('q_ex_1_s3', 'exam_1_science', 'What do we use to TASTE?', 'Tongue', 'Teeth', 'Lips', 'Nose'),
('q_ex_1_s4', 'exam_1_science', 'A caterpillar becomes a?', 'Butterfly', 'Spider', 'Ant', 'Bee'),
('q_ex_1_s5', 'exam_1_science', 'Which sense uses your skin?', 'Touching', 'Hearing', 'Seeing', 'Smelling'),
('q_ex_1_s6', 'exam_1_science', 'What is a SOUR taste?', 'Lemon', 'Cookie', 'Milk', 'Apple'),
('q_ex_1_s7', 'exam_1_science', 'What part of plant gets water?', 'Roots', 'Flower', 'Stem', 'Leaves'),
('q_ex_1_s8', 'exam_1_science', 'Water freezing becomes?', 'Ice', 'Gas', 'Soup', 'Steam'),
('q_ex_1_s9', 'exam_1_science', 'The sun is a?', 'Star', 'Planet', 'Moon', 'Cloud'),
('q_ex_1_s10', 'exam_1_science', 'How many seasons are there?', '4', '2', '7', '12'),
-- Social 1
('q_ex_1_so1', 'exam_1_social', 'Who was the first President?', 'George Washington', 'Abraham Lincoln', 'Ernie', 'Thomas Jefferson'),
('q_ex_1_so2', 'exam_1_social', 'What is our national bird?', 'Bald Eagle', 'Parrot', 'Duck', 'Owl'),
('q_ex_1_so3', 'exam_1_social', 'The US flag colors are?', 'Red, White, Blue', 'Green and Yellow', 'Purple', 'Orange'),
('q_ex_1_so4', 'exam_1_social', 'Where does the President live?', 'White House', 'Tree House', 'School', 'Library'),
('q_ex_1_so5', 'exam_1_social', 'What shows the 50 states?', '50 Stars', '50 Stripes', '50 Birds', '50 Hearts'),
('q_ex_1_so6', 'exam_1_social', 'A person who makes a rule?', 'Leader', 'Follower', 'Pet', 'Student'),
('q_ex_1_so7', 'exam_1_social', 'Map drawing of the world?', 'Globe', 'Circle', 'Box', 'Page'),
('q_ex_1_so8', 'exam_1_social', 'Who helps us stay safe?', 'Police Officer', 'Alien', 'Dracula', 'Wolf'),
('q_ex_1_so9', 'exam_1_social', 'Where is the capital of USA?', 'Washington D.C.', 'New York', 'Los Angeles', 'Chicago'),
('q_ex_1_so10', 'exam_1_social', 'A symbol of freedom is?', 'Statue of Liberty', 'A car', 'A toy', 'A book'),
-- English 1
('q_ex_1_e1', 'exam_1_english', 'Which is a noun (person)?', 'Teacher', 'Run', 'Fast', 'Yellow'),
('q_ex_1_e2', 'exam_1_english', 'Which is an action word?', 'Jump', 'Box', 'Apple', 'Kind'),
('q_ex_1_e3', 'exam_1_english', 'What is the end mark? (.)', 'Period', 'Comma', 'Star', 'Dot'),
('q_ex_1_e4', 'exam_1_english', 'What is the end mark for ASK? (?)', 'Question Mark', 'Dot', 'Slash', 'Comma'),
('q_ex_1_e5', 'exam_1_english', 'Make plural of Cat?', 'Cats', 'Catted', 'Catting', 'Cates'),
('q_ex_1_e6', 'exam_1_english', 'Which letter is a vowel?', 'A', 'B', 'C', 'D'),
('q_ex_1_e7', 'exam_1_english', 'Which word is capitalized?', 'Ernie', 'run', 'gator', 'play'),
('q_ex_1_e8', 'exam_1_english', 'Correct word for I (have)?', 'Have', 'Has', 'Having', 'Haved'),
('q_ex_1_e9', 'exam_1_english', 'Opposite of Up?', 'Down', 'Sky', 'High', 'Low'),
('q_ex_1_e10', 'exam_1_english', 'How many syllables in "Gator"?', '2', '1', '3', '4');

-- ==========================================
-- GRADE 2: 2ND GRADE
-- ==========================================

INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name) VALUES
('exam_2_math', 'Math', 2, 1, TRUE, 'Grade 2 Math Exam'),
('exam_2_science', 'Science', 2, 1, TRUE, 'Grade 2 Matter Exam'),
('exam_2_social', 'Social Studies', 2, 1, TRUE, 'Grade 2 Civics Exam'),
('exam_2_english', 'English', 2, 1, TRUE, 'Grade 2 Grammar Exam');

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
-- Math 2
('q_ex_2_m1', 'exam_2_math', '15 + 17 = ?', '32', '22', '31', '25'),
('q_ex_2_m2', 'exam_2_math', 'What is 32 - 15?', '17', '27', '18', '22'),
('q_ex_2_m3', 'exam_2_math', 'In 583, what is the value of 5?', '500', '50', '5', '5000'),
('q_ex_2_m4', 'exam_2_math', 'Is 24 Even or Odd?', 'Even', 'Odd', 'Both', 'Neither'),
('q_ex_2_m5', 'exam_2_math', 'What is 3 rows of 4?', '12', '7', '10', '15'),
('q_ex_2_m6', 'exam_2_math', 'What is 50 + 50?', '100', '5050', '150', '200'),
('q_ex_2_m7', 'exam_2_math', 'How many tens in 145?', '4', '1', '5', '14'),
('q_ex_2_m8', 'exam_2_math', 'What is 100 - 1?', '99', '101', '90', '10'),
('q_ex_2_m9', 'exam_2_math', 'Skip count: 5, 10, 15, ?', '20', '30', '16', '10'),
('q_ex_2_m10', 'exam_2_math', 'A quarter is worth?', '25 cents', '10 cents', '1 cent', '50 cents'),
-- Science 2
('q_ex_2_s1', 'exam_2_science', 'Ice is which state of matter?', 'Solid', 'Liquid', 'Gas', 'Steam'),
('q_ex_2_s2', 'exam_2_science', 'Water turning to gas is?', 'Evaporation', 'Freezing', 'Melting', 'Rain'),
('q_ex_2_s3', 'exam_2_science', 'What state takes shape of container?', 'Liquid', 'Solid', 'Gas', 'Rock'),
('q_ex_2_s4', 'exam_2_science', 'A rock is which state?', 'Solid', 'Liquid', 'Gas', 'Air'),
('q_ex_2_s5', 'exam_2_science', 'Boiling water makes?', 'Steam (Gas)', 'Ice', 'Rock', 'Milk'),
('q_ex_2_s6', 'exam_2_science', 'Helium in balloon is a?', 'Gas', 'Solid', 'Liquid', 'Ice'),
('q_ex_2_s7', 'exam_2_science', 'Land surrounded by water?', 'Island', 'Lake', 'Valley', 'Hill'),
('q_ex_2_s8', 'exam_2_science', 'A dry place with little water?', 'Desert', 'Swamp', 'Forest', 'Beach'),
('q_ex_2_s9', 'exam_2_science', 'A turtle has a shell for?', 'Protection', 'Speed', 'Swimming', 'Flying'),
('q_ex_2_s10', 'exam_2_science', 'Fish use gills to?', 'Breathe underwater', 'Eat', 'Fly', 'Sleep'),
-- Social 2
('q_ex_2_so1', 'exam_2_social', 'Who is the leader of a state?', 'Governor', 'President', 'Mayor', 'King'),
('q_ex_2_so2', 'exam_2_social', 'An apple purchased is a?', 'Good', 'Service', 'Tax', 'Rule'),
('q_ex_2_so3', 'exam_2_social', 'Teaching in a school is a?', 'Service', 'Good', 'Toy', 'Game'),
('q_ex_2_so4', 'exam_2_social', 'Laws are made to?', 'Keep us safe', 'Make us sad', 'Cost money', 'Waste time'),
('q_ex_2_so5', 'exam_2_social', 'How do citizens choose leaders?', 'Voting', 'Guessing', 'Fighting', 'Asking'),
('q_ex_2_so6', 'exam_2_social', 'A person who buys goods?', 'Consumer', 'Producer', 'Seller', 'Worker'),
('q_ex_2_so7', 'exam_2_social', 'Where do we buy stamps?', 'Post Office', 'Beach', 'Gym', 'Park'),
('q_ex_2_so8', 'exam_2_social', 'What is the capital of USA?', 'Washington D.C.', 'New York', 'London', 'Paris'),
('q_ex_2_so9', 'exam_2_social', 'Who is in the Executive branch?', 'President', 'Judge', 'Senator', 'Mayor'),
('q_ex_2_so10', 'exam_2_social', 'A good citizen?', 'Helps others', 'Lutters', 'Steals', 'Mean'),
-- English 2
('q_ex_2_e1', 'exam_2_english', 'Which is a Proper Noun?', 'Fay Gator', 'alligator', 'bayou', 'game'),
('q_ex_2_e2', 'exam_2_english', 'Past tense of Walk?', 'Walked', 'Walking', 'Walker', 'Walks'),
('q_ex_2_e3', 'exam_2_english', 'Which word is a verb?', 'Run', 'Apple', 'Kind', 'Blue'),
('q_ex_2_e4', 'exam_2_english', 'Plural of Box?', 'Boxes', 'Boxs', 'Boxed', 'Boxing'),
('q_ex_2_e5', 'exam_2_english', 'Which word is an adjective?', 'Quiet', 'Jump', 'Box', 'Ernie'),
('q_ex_2_e6', 'exam_2_english', 'Antonym of Hot?', 'Cold', 'Warm', 'Fire', 'Sunny'),
('q_ex_2_e7', 'exam_2_english', 'Synonym of Big?', 'Large', 'Small', 'Tiny', 'Little'),
('q_ex_2_e8', 'exam_2_english', 'A group of sentences?', 'Paragraph', 'Word', 'Letter', 'Book'),
('q_ex_2_e9', 'exam_2_english', 'I (am) happy. Which is verb?', 'am', 'I', 'happy', '.'),
('q_ex_2_e10', 'exam_2_english', 'Correct: (There/Their) house.', 'Their', 'There', 'They''re', 'Thare');

-- ==========================================
-- GRADE 3: 3RD GRADE
-- ==========================================

INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name) VALUES
('exam_3_math', 'Math', 3, 1, TRUE, 'Grade 3 Math Exam'),
('exam_3_science', 'Science', 3, 1, TRUE, 'Grade 3 Ecosystems Exam'),
('exam_3_social', 'Social Studies', 3, 1, TRUE, 'Grade 3 Ancient Exam'),
('exam_3_english', 'English', 3, 1, TRUE, 'Grade 3 Punctuation Exam');

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
-- Math 3
('q_ex_3_m1', 'exam_3_math', '3 x 4 = ?', '12', '7', '9', '15'),
('q_ex_3_m2', 'exam_3_math', '20 / 5 = ?', '4', '15', '10', '5'),
('q_ex_3_m3', 'exam_3_math', 'What is 1/2 of 10?', '5', '2', '12', '20'),
('q_ex_3_m4', 'exam_3_math', 'How many sides on a hexagon?', '6', '5', '8', '4'),
('q_ex_3_m5', 'exam_3_math', 'Perimeter of 2x3 square?', '10', '6', '5', '12'),
('q_ex_3_m6', 'exam_3_math', 'Area of 4x4 square?', '16', '8', '12', '20'),
('q_ex_3_m7', 'exam_3_math', 'What is 5 x 6?', '30', '25', '11', '35'),
('q_ex_3_m8', 'exam_3_math', '18 / 2 = ?', '9', '20', '16', '10'),
('q_ex_3_m9', 'exam_3_math', 'Which fraction is half?', '1/2', '1/4', '1/3', '2/1'),
('q_ex_3_m10', 'exam_3_math', 'A triangle has how many angles?', '3', '4', '2', '5'),
-- Science 3
('q_ex_3_s1', 'exam_3_science', 'Who produces their own food?', 'Plants', 'Animals', 'Humans', 'Fungi'),
('q_ex_3_s2', 'exam_3_science', 'What powers the water cycle?', 'The Sun', 'Wind', 'Moon', 'Gravity'),
('q_ex_3_s3', 'exam_3_science', 'Water turning to gas is?', 'Evaporation', 'Condensed', 'Rain', 'Freezing'),
('q_ex_3_s4', 'exam_3_science', 'How many planets in our system?', '8', '9', '7', '10'),
('q_ex_3_s5', 'exam_3_science', 'Which planet is the RED planet?', 'Mars', 'Jupiter', 'Venus', 'Mercury'),
('q_ex_3_s6', 'exam_3_science', 'What keeps us on the ground?', 'Gravity', 'Wind', 'Glue', 'Magnets'),
('q_ex_3_s7', 'exam_3_science', 'Fungi and bacteria are?', 'Decomposers', 'Producers', 'Consumers', 'Rocks'),
('q_ex_3_s8', 'exam_3_science', 'Precipitation is?', 'Rain/Snow/Hail', 'Clouding', 'Gas', 'Soil'),
('q_ex_3_s9', 'exam_3_science', 'Earth orbits the Sun in?', '365 days', '24 hours', '30 days', '7 days'),
('q_ex_3_s10', 'exam_3_science', 'What is an omnivore?', 'Eats plants and meat', 'Eats only grass', 'Eats only meat', 'Eats only rocks'),
-- Social 3
('q_ex_3_so1', 'exam_3_social', 'Ancient Egyptians built?', 'Pyramids', 'Skyscrapers', 'Trains', 'Cars'),
('q_ex_3_so2', 'exam_3_social', 'Ancient Greeks held the first?', 'Olympics', 'Super Bowl', 'Birthday', 'Exam'),
('q_ex_3_so3', 'exam_3_social', 'How many continents?', '7', '5', '8', '6'),
('q_ex_3_so4', 'exam_3_social', 'Small model of the Earth?', 'Globe', 'Map', 'Page', 'Picture'),
('q_ex_3_so5', 'exam_3_social', 'The imaginary line at center?', 'Equator', 'Prime Meridian', 'Belt', 'Post'),
('q_ex_3_so6', 'exam_3_social', 'A person who travels for goods?', 'Trader', 'Leader', 'Follower', 'Pet'),
('q_ex_3_so7', 'exam_3_social', 'Largest continent?', 'Asia', 'Africa', 'Europe', 'America'),
('q_ex_3_so8', 'exam_3_social', 'Compass rose shows?', 'N, S, E, W', 'Colors', 'Roads', 'Distance'),
('q_ex_3_so9', 'exam_3_social', 'Ancient Romans lived in?', 'Italy', 'China', 'Egypt', 'Mexico'),
('q_ex_3_so10', 'exam_3_social', 'Where is the Great Wall?', 'China', 'Egypt', 'USA', 'Brazil'),
-- English 3
('q_ex_3_e1', 'exam_3_english', 'What mark ends excitement!?', 'Exclamation Point', 'Period', 'Comma', 'Dot'),
('q_ex_3_e2', 'exam_3_english', 'Which is a pronoun?', 'They', 'House', 'Run', 'Kind'),
('q_ex_3_e3', 'exam_3_english', 'Plural of Mouse?', 'Mice', 'Mouses', 'Micey', 'Mices'),
('q_ex_3_e4', 'exam_3_english', 'Main part of word?', 'Root', 'Prefix', 'Suffix', 'End'),
('q_ex_3_e5', 'exam_3_english', 'A word that describes noun?', 'Adjective', 'Verb', 'Pronoun', 'Adverb'),
('q_ex_3_e6', 'exam_3_english', 'Commas separate items in?', 'List', 'Word', 'Letter', 'Book'),
('q_ex_3_e7', 'exam_3_english', 'A book about oneself?', 'Autobiography', 'Fiction', 'Fantasy', 'Glossary'),
('q_ex_3_e8', 'exam_3_english', 'Opposite of First?', 'Last', 'Best', 'Next', 'One'),
('q_ex_3_e9', 'exam_3_english', 'Correct spelling?', 'Beautiful', 'Beatiful', 'Beautifull', 'Beatfull'),
('q_ex_3_e10', 'exam_3_english', 'Word to join sentences?', 'Conjunction', 'Verb', 'Noun', 'Mark');

-- ==========================================
-- GRADE 4: 4TH GRADE
-- ==========================================

INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name) VALUES
('exam_4_math', 'Math', 4, 1, TRUE, 'Grade 4 Math Exam'),
('exam_4_science', 'Science', 4, 1, TRUE, 'Grade 4 Energy Exam'),
('exam_4_social', 'Social Studies', 4, 1, TRUE, 'Grade 4 US Regions Exam'),
('exam_4_english', 'English', 4, 1, TRUE, 'Grade 4 ELA Exam');

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
-- Math 4
('q_ex_4_m1', 'exam_4_math', 'Factors of 12?', '1, 2, 3, 4, 6, 12', '1, 2, 12', '3, 4, 8', '2, 4, 6, 10'),
('q_ex_4_m2', 'exam_4_math', 'What is 100 / 4?', '25', '20', '50', '40'),
('q_ex_4_m3', 'exam_4_math', 'Equivalent to 1/2?', '2/4', '1/3', '2/2', '1/4'),
('q_ex_4_m4', 'exam_4_math', 'Angle of 90 degrees is?', 'Right', 'Acute', 'Obtuse', 'Straight'),
('q_ex_4_m5', 'exam_4_math', 'How many feet in a yard?', '3', '12', '1', '10'),
('q_ex_4_m6', 'exam_4_math', 'Value of 7 in 7,432?', '7,000', '700', '70', '7'),
('q_ex_4_m7', 'exam_4_math', '144 / 12 = ?', '12', '14', '10', '16'),
('q_ex_4_m8', 'exam_4_math', 'What is 0.5 as a fraction?', '1/2', '1/5', '1/4', '5/1'),
('q_ex_4_m9', 'exam_4_math', 'Angle less than 90?', 'Acute', 'Obtuse', 'Right', 'Straight'),
('q_ex_4_m10', 'exam_4_math', 'How many inches in a foot?', '12', '10', '3', '36'),
-- Science 4
('q_ex_4_s1', 'exam_4_science', 'Who starts food chains?', 'Producers', 'Lions', 'Humans', 'Fungi'),
('q_ex_4_s2', 'exam_4_science', 'Matter solid to liquid?', 'Melting', 'Freezing', 'Evaporating', 'Growing'),
('q_ex_4_s3', 'exam_4_science', 'Flow of electrons is?', 'Electricity', 'Water', 'Wind', 'Sound'),
('q_ex_4_s4', 'exam_4_science', 'Energy of motion?', 'Kinetic', 'Potential', 'Static', 'Heat'),
('q_ex_4_s5', 'exam_4_science', 'Material that conducts?', 'Metal', 'Rubber', 'Wood', 'Plastic'),
('q_ex_4_s6', 'exam_4_science', 'Animal that only eats meat?', 'Carnivore', 'Herbivore', 'Producer', 'Plant'),
('q_ex_4_s7', 'exam_4_science', 'Gas turns to liquid?', 'Condensation', 'Melting', 'Flowing', 'Growing'),
('q_ex_4_s8', 'exam_4_science', 'Renewable energy comes from?', 'Sun/Wind', 'Coal', 'Gas', 'Rocks'),
('q_ex_4_s9', 'exam_4_science', 'Breaks down dead matter?', 'Decomposers', 'Producers', 'Predators', 'Birds'),
('q_ex_4_s10', 'exam_4_science', 'Does air have mass?', 'Yes', 'No', 'Only when windy', 'No idea'),
-- Social 4
('q_ex_4_so1', 'exam_4_social', 'Number of US Gov branches?', '3', '2', '4', '1'),
('q_ex_4_so2', 'exam_4_social', 'Tallest mountain on Earth?', 'Mt. Everest', 'Kilimanjaro', 'Whitney', 'Rainier'),
('q_ex_4_so3', 'exam_4_social', 'Branch that makes laws?', 'Legislative', 'Executive', 'Judicial', 'Army'),
('q_ex_4_so4', 'exam_4_social', 'Largest ocean?', 'Pacific', 'Atlantic', 'Arctic', 'Indian'),
('q_ex_4_so5', 'exam_4_social', 'First 10 amendments?', 'Bill of Rights', 'Constitution', 'Rule Book', 'Menu'),
('q_ex_4_so6', 'exam_4_social', 'Where is the Bayou?', 'Gulf Coast', 'California', 'Maine', 'Alaska'),
('q_ex_4_so7', 'exam_4_social', 'Longest river in world?', 'Nile', 'Mississippi', 'Amazon', 'Yangtze'),
('q_ex_4_so8', 'exam_4_social', 'Which branch judges laws?', 'Judicial', 'Executive', 'Army', 'Legislative'),
('q_ex_4_so9', 'exam_4_social', 'Freedom of speech is?', '1st Amendment', '2nd', '5th', '10th'),
('q_ex_4_so10', 'exam_4_social', 'Commander in Chief is?', 'The President', 'The Mayor', 'The General', 'Ernie'),
-- English 4
('q_ex_4_e1', 'exam_4_english', 'Which is a verb?', 'Write', 'Pencil', 'Red', 'Slow'),
('q_ex_4_e2', 'exam_4_english', 'Noun in "The cat ran"?', 'cat', 'ran', 'the', 'The'),
('q_ex_4_e3', 'exam_4_english', 'Which is an adverb?', 'Quickly', 'Fast', 'Run', 'Boy'),
('q_ex_4_e4', 'exam_4_english', 'A word that means same?', 'Synonym', 'Antonym', 'Homonym', 'Letter'),
('q_ex_4_e5', 'exam_4_english', 'Opposite word is?', 'Antonym', 'Synonym', 'Rhyme', 'Verse'),
('q_ex_4_e6', 'exam_4_english', 'Prefix for "not"?', 'Un-', 'Pre-', 'Re-', 'De-'),
('q_ex_4_e7', 'exam_4_english', 'Suffix for "full of"?', '-ful', '-less', '-ing', '-ed'),
('q_ex_4_e8', 'exam_4_english', 'Direct quote mark?', 'Quotation Marks', 'Comma', 'Period', 'Slash'),
('q_ex_4_e9', 'exam_4_english', 'Main idea of a story?', 'Theme', 'Title', 'Page', 'Cover'),
('q_ex_4_e10', 'exam_4_english', 'Words with same sound?', 'Homophone', 'Antonym', 'Synonym', 'Noun');

-- ==========================================
-- GRADE 5: 5TH GRADE
-- ==========================================

INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name) VALUES
('exam_5_math', 'Math', 5, 1, TRUE, 'Grade 5 PEMDAS Exam'),
('exam_5_science', 'Science', 5, 1, TRUE, 'Grade 5 Body Systems Exam'),
('exam_5_social', 'Social Studies', 5, 1, TRUE, 'Grade 5 US History Exam'),
('exam_5_english', 'English', 5, 1, TRUE, 'Grade 5 ELA Exam');

INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
-- Math 5
('q_ex_5_m1', 'exam_5_math', '5 + 2 x 3 = ?', '11', '21', '13', '10'),
('q_ex_5_m2', 'exam_5_math', '0.25 + 0.50 = ?', '0.75', '0.30', '0.55', '1.00'),
('q_ex_5_m3', 'exam_5_math', 'Convert 3/2 to mixed?', '1 1/2', '2 1/3', '1 1/3', '3 1/2'),
('q_ex_5_m4', 'exam_5_math', 'Formula for Volume?', 'L x W x H', 'L + W + H', 'Area x 2', 'L x W'),
('q_ex_5_m5', 'exam_5_math', 'Average of 2, 4, 6?', '4', '12', '6', '3'),
('q_ex_5_m6', 'exam_5_math', '1,000,000 has how many zeros?', '6', '5', '7', '4'),
('q_ex_5_m7', 'exam_5_math', 'What is 5/5?', '1 whole', '5 wholes', 'None', 'Half'),
('q_ex_5_m8', 'exam_5_math', 'Middle number in list?', 'Median', 'Mean', 'Mode', 'Range'),
('q_ex_5_m9', 'exam_5_math', 'Volume prism 2x3x4?', '24', '12', '9', '20'),
('q_ex_5_m10', 'exam_5_math', 'Point (0,0)?', 'Origin', 'Corner', 'End', 'Center'),
-- Science 5
('q_ex_5_s1', 'exam_5_science', 'System that pumps blood?', 'Circulatory', 'Skeletal', 'Digestive', 'Nervous'),
('q_ex_5_s2', 'exam_5_science', 'Air surrounding Earth?', 'Atmosphere', 'Geosphere', 'Biosphere', 'Hydrosphere'),
('q_ex_5_s3', 'exam_5_science', 'Force keeping planets orbit?', 'Gravity', 'Wind', 'Magnetism', 'Magic'),
('q_ex_5_s4', 'exam_5_science', 'System for breathing?', 'Respiratory', 'Muscular', 'Nervous', 'Skeletal'),
('q_ex_5_s5', 'exam_5_science', 'All water on Earth?', 'Hydrosphere', 'Space', 'Clouds', 'Atmos'),
('q_ex_5_s6', 'exam_5_science', 'Distance light in 1 year?', 'Light year', 'Mile', 'Kilometer', 'Gallon'),
('q_ex_5_s7', 'exam_5_science', 'Main control center body?', 'Brain', 'Heart', 'Stomach', 'Bone'),
('q_ex_5_s8', 'exam_5_science', 'Breaking rocks process?', 'Weathering', 'Seeding', 'Growing', 'Farming'),
('q_ex_5_s9', 'exam_5_science', 'Center of solar system?', 'The Sun', 'Earth', 'Jupiter', 'The Moon'),
('q_ex_5_s10', 'exam_5_science', 'Movement of sediment?', 'Erosion', 'Gravity', 'Freezing', 'Melting'),
-- Social 5
('q_ex_5_so1', 'exam_5_social', 'War between North and South?', 'Civil War', 'Revolutionary', 'WWI', 'WWII'),
('q_ex_5_so2', 'exam_5_social', 'Date of Declaration?', 'July 4, 1776', 'Oct 12, 1492', 'Dec 25, 1800', 'Jan 1, 1901'),
('q_ex_5_so3', 'exam_5_social', 'Civil Rights leader dream?', 'MLK Jr.', 'Malcolm X', 'Rosa Parks', 'Lincoln'),
('q_ex_5_so4', 'exam_5_social', 'First English settlement?', 'Jamestown', 'Plymouth', 'Roanoke', 'New York'),
('q_ex_5_so5', 'exam_5_social', 'President during Civil War?', 'Abraham Lincoln', 'Washington', 'Jefferson', 'Grant'),
('q_ex_5_so6', 'exam_5_social', '19th Amendment gave?', 'Women vote', 'Free speech', 'Arms', 'Trial'),
('q_ex_5_so7', 'exam_5_social', 'Tea tossed into harbor?', 'Boston Tea Party', 'Beach Party', 'Exam', 'Gift'),
('q_ex_5_so8', 'exam_5_social', 'Document that freed slaves?', 'Emancipation Proc', 'Constitution', 'Treaty', 'Law'),
('q_ex_5_so9', 'exam_5_social', 'First US President?', 'George Washington', 'Lincoln', 'Ernie', 'Jefferson'),
('q_ex_5_so10', 'exam_5_social', 'Country''s law document?', 'Constitution', 'Dictionary', 'Newspaper', 'Catalog'),
-- English 5
('q_ex_5_e1', 'exam_5_english', 'Person who wrote a story?', 'Author', 'Reader', 'Publisher', 'Critic'),
('q_ex_5_e2', 'exam_5_english', 'Which is a conjunction?', 'And', 'Cat', 'Run', 'Kind'),
('q_ex_5_e3', 'exam_5_english', 'An exaggerated statement?', 'Hyperbole', 'Simile', 'Fact', 'Truth'),
('q_ex_5_e4', 'exam_5_english', 'Comparison using Like or As?', 'Simile', 'Metaphor', 'Noun', 'Verb'),
('q_ex_5_e5', 'exam_5_english', 'Word to show position?', 'Preposition', 'Verb', 'Noun', 'Pronoun'),
('q_ex_5_e6', 'exam_5_english', 'Setting of a story?', 'When and Where', 'Who and How', 'What and Why', 'Page count'),
('q_ex_5_e7', 'exam_5_english', 'Correct plural of "Child"?', 'Children', 'Childs', 'Childes', 'Childen'),
('q_ex_5_e8', 'exam_5_english', 'A play on words is a?', 'Pun', 'Simile', 'Verb', 'Mark'),
('q_ex_5_e9', 'exam_5_english', 'A word that replaces noun?', 'Pronoun', 'Adverb', 'Mark', 'Page'),
('q_ex_5_e10', 'exam_5_english', 'What is the "Climax"?', 'Highest point of story', 'Start', 'End', 'Title');
