-- Batch 3: Grade 2 (2nd Grade) and Grade 3 (3rd Grade)
-- Adding 10 new questions per challenge (Total 200 questions)

-- ==========================================
-- GRADE 2: 2ND GRADE
-- Topics: Math (1-5), Science (6-8), Social (9-10)
-- ==========================================

-- LVL 1 MATH: Addition with Regrouping
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_1_11', 'gen_2_1', '15 + 17 = ?', '32', '22', '31', '25'),
('q_2_1_12', 'gen_2_1', '28 + 14 = ?', '42', '32', '41', '38'),
('q_2_1_13', 'gen_2_1', '36 + 19 = ?', '55', '45', '54', '49'),
('q_2_1_14', 'gen_2_1', '47 + 23 = ?', '70', '60', '71', '67'),
('q_2_1_15', 'gen_2_1', '52 + 29 = ?', '81', '71', '82', '79'),
('q_2_1_16', 'gen_2_1', '13 + 38 = ?', '51', '41', '52', '48'),
('q_2_1_17', 'gen_2_1', '25 + 25 = ?', '50', '40', '51', '60'),
('q_2_1_18', 'gen_2_1', '34 + 27 = ?', '61', '51', '62', '58'),
('q_2_1_19', 'gen_2_1', '46 + 18 = ?', '64', '54', '63', '59'),
('q_2_1_20', 'gen_2_1', '19 + 19 = ?', '38', '28', '37', '40');

-- LVL 2 MATH: Subtraction with Borrowing
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_2_11', 'gen_2_2', '32 - 15 = ?', '17', '27', '18', '22'),
('q_2_2_12', 'gen_2_2', '41 - 14 = ?', '27', '37', '26', '31'),
('q_2_2_13', 'gen_2_2', '50 - 23 = ?', '27', '37', '28', '33'),
('q_2_2_14', 'gen_2_2', '63 - 29 = ?', '34', '44', '33', '41'),
('q_2_2_15', 'gen_2_2', '75 - 38 = ?', '37', '47', '36', '43'),
('q_2_2_16', 'gen_2_2', '82 - 45 = ?', '37', '47', '38', '35'),
('q_2_2_17', 'gen_2_2', '44 - 18 = ?', '26', '36', '25', '24'),
('q_2_2_18', 'gen_2_2', '51 - 22 = ?', '29', '39', '28', '31'),
('q_2_2_19', 'gen_2_2', '90 - 46 = ?', '44', '54', '43', '45'),
('q_2_2_20', 'gen_2_2', '30 - 11 = ?', '19', '21', '29', '18');

-- LVL 3 MATH: Expanded Form & Place Value (Hundreds)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_3_11', 'gen_2_3', 'What is 200 + 40 + 5?', '245', '2045', '254', '425'),
('q_2_3_12', 'gen_2_3', 'In 583, what is the value of 5?', '500', '50', '5', '5000'),
('q_2_3_13', 'gen_2_3', 'In 719, what is the value of 1?', '10', '1', '100', '1000'),
('q_2_3_14', 'gen_2_3', 'What is 300 + 80 + 2?', '382', '3082', '832', '283'),
('q_2_3_15', 'gen_2_3', 'In 426, what digit is in the ones place?', '6', '2', '4', '42'),
('q_2_3_16', 'gen_2_3', 'What is 100 + 90 + 0?', '190', '1090', '910', '109'),
('q_2_3_17', 'gen_2_3', 'In 907, what digit is in the tens place?', '0', '9', '7', '90'),
('q_2_3_18', 'gen_2_3', 'What is 600 + 0 + 3?', '603', '630', '6003', '306'),
('q_2_3_19', 'gen_2_3', 'How many tens are in 250?', '5', '2', '0', '25'),
('q_2_3_20', 'gen_2_3', 'What is 500 + 7?', '507', '570', '5007', '705');

-- LVL 4 MATH: Skip Counting & Even/Odd
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_4_11', 'gen_2_4', 'Is 15 Even or Odd?', 'Odd', 'Even', 'Neither', 'Both'),
('q_2_4_12', 'gen_2_4', 'Is 24 Even or Odd?', 'Even', 'Odd', 'Neither', 'Both'),
('q_2_4_13', 'gen_2_4', 'What comes next: 5, 10, 15, ?', '20', '25', '16', '10'),
('q_2_4_14', 'gen_2_4', 'What comes next: 10, 20, 30, ?', '40', '50', '31', '10'),
('q_2_4_15', 'gen_2_4', 'What comes next: 2, 4, 6, 8, ?', '10', '9', '12', '11'),
('q_2_4_16', 'gen_2_4', 'Which number is EVEN?', '12', '13', '15', '19'),
('q_2_4_17', 'gen_2_4', 'Which number is ODD?', '21', '22', '24', '20'),
('q_2_4_18', 'gen_2_4', 'What comes next: 100, 200, 300, ?', '400', '500', '301', '1000'),
('q_2_4_19', 'gen_2_4', 'Count by 5: 25, 30, 35, ?', '40', '45', '50', '36'),
('q_2_4_20', 'gen_2_4', 'Which digit at the end makes a number EVEN?', '0, 2, 4, 6, 8', '1, 3, 5, 7, 9', 'Only 0', 'All numbers');

-- LVL 5 MATH: Introduction to Multiplication (Arrays)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_5_11', 'gen_2_5', '2 rows of 3 is?', '6', '5', '2', '3'),
('q_2_5_12', 'gen_2_5', '5 + 5 + 5 is?', '15', '10', '20', '3'),
('q_2_5_13', 'gen_2_5', '3 groups of 4 is?', '12', '7', '10', '9'),
('q_2_5_14', 'gen_2_5', '2 + 2 + 2 + 2 is?', '8', '6', '10', '4'),
('q_2_5_15', 'gen_2_5', 'What is 3 times 3?', '9', '6', '12', '1'),
('q_2_5_16', 'gen_2_5', '2 rows of 10 is?', '20', '12', '10', '2'),
('q_2_5_17', 'gen_2_5', 'What is 5 times 2?', '10', '7', '12', '2'),
('q_2_5_18', 'gen_2_5', '4 groups of 2 is?', '8', '6', '4', '10'),
('q_2_5_19', 'gen_2_5', 'What is 10 times 1?', '10', '1', '11', '0'),
('q_2_5_20', 'gen_2_5', 'What is 0 times 5?', '0', '5', '1', '10');

-- LVL 6 SCIENCE: Landforms
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_6_11', 'gen_2_6', 'A high area with a peak is a?', 'Mountain', 'Valley', 'Plain', 'Plato'),
('q_2_6_12', 'gen_2_6', 'Low land between mountains?', 'Valley', 'Hill', 'Island', 'Canyon'),
('q_2_6_13', 'gen_2_6', 'Land surrounded by water?', 'Island', 'Lake', 'Mountain', 'Desert'),
('q_2_6_14', 'gen_2_6', 'A large flat area of land?', 'Plain', 'Hill', 'Valley', 'Mountain'),
('q_2_6_15', 'gen_2_6', 'A deep cut in the Earth?', 'Canyon', 'Plato', 'Island', 'Forest'),
('q_2_6_16', 'gen_2_6', 'Water surrounded by land?', 'Lake', 'Island', 'River', 'Ocean'),
('q_2_6_17', 'gen_2_6', 'A dry place with little water?', 'Desert', 'Swamp', 'Rainforest', 'Beach'),
('q_2_6_18', 'gen_2_6', 'A large body of salt water?', 'Ocean', 'Pond', 'River', 'Lake'),
('q_2_6_19', 'gen_2_6', 'A piece of land with water on 3 sides?', 'Peninsula', 'Island', 'Mountain', 'Valley'),
('q_2_6_20', 'gen_2_6', 'Where a river meets the sea?', 'Delta', 'Peak', 'Valley', 'Canyon');

-- LVL 7 SCIENCE: States of Matter
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_7_11', 'gen_2_7', 'Ice is which state of matter?', 'Solid', 'Liquid', 'Gas', 'Steam'),
('q_2_7_12', 'gen_2_7', 'Water is which state of matter?', 'Liquid', 'Solid', 'Gas', 'Ice'),
('q_2_7_13', 'gen_2_7', 'Air is which state of matter?', 'Gas', 'Solid', 'Liquid', 'Ice'),
('q_2_7_14', 'gen_2_7', 'Which state keeps its own shape?', 'Solid', 'Liquid', 'Gas', 'Water'),
('q_2_7_15', 'gen_2_7', 'Which state takes the shape of its container?', 'Liquid', 'Solid', 'Rock', 'Brick'),
('q_2_7_16', 'gen_2_7', 'Boiling water makes?', 'Gas (Steam)', 'Ice', 'Rock', 'Dirt'),
('q_2_7_17', 'gen_2_7', 'A rock is which state?', 'Solid', 'Liquid', 'Gas', 'Air'),
('q_2_7_18', 'gen_2_7', 'Milk is which state?', 'Liquid', 'Solid', 'Gas', 'Steam'),
('q_2_7_19', 'gen_2_7', 'Helium in a balloon is a?', 'Gas', 'Solid', 'Liquid', 'Ice'),
('q_2_7_20', 'gen_2_7', 'Freezing a liquid makes it a?', 'Solid', 'Gas', 'Steam', 'Hot');

-- LVL 8 SCIENCE: Habitats & Adaptations
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_8_11', 'gen_2_8', 'A polar bear has thick fur for?', 'Warmth', 'Swimming', 'Flying', 'Climbing'),
('q_2_8_12', 'gen_2_8', 'Camels store fat in humps for?', 'Long journeys', 'Water', 'Speed', 'Sleeping'),
('q_2_8_13', 'gen_2_8', 'Cactus have spines to?', 'Save water', 'Look pretty', 'Grow faster', 'Fly'),
('q_2_8_14', 'gen_2_8', 'A duck has webbed feet for?', 'Swimming', 'Running', 'Grasping', 'Typing'),
('q_2_8_15', 'gen_2_8', 'Fish use gills to?', 'Breathe underwater', 'Eat', 'Sleep', 'Fly'),
('q_2_8_16', 'gen_2_8', 'Monkeys have long tails for?', 'Balance', 'Eating', 'Swimming', 'Balking'),
('q_2_8_17', 'gen_2_8', 'Rabbits have big ears for?', 'Hearing and Cooling', 'Eating', 'Sleeping', 'Seeing'),
('q_2_8_18', 'gen_2_8', 'Frogs have long tongues for?', 'Catching bugs', 'Drinking', 'Singing', 'Talking'),
('q_2_8_19', 'gen_2_8', 'Birds migrate to?', 'Avoid cold', 'Play', 'Sleep', 'Hide'),
('q_2_8_20', 'gen_2_8', 'A turtle has a shell for?', 'Protection', 'Speed', 'Swimming', 'Flying');

-- LVL 9 SOCIAL: Goods and Services
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_9_11', 'gen_2_9', 'An apple is a?', 'Good', 'Service', 'Idea', 'Feeling'),
('q_2_9_12', 'gen_2_9', 'A haircut is a?', 'Service', 'Good', 'Resource', 'Tax'),
('q_2_9_13', 'gen_2_9', 'Toys are?', 'Goods', 'Services', 'Taxes', 'Rules'),
('q_2_9_14', 'gen_2_9', 'Teaching is a?', 'Service', 'Good', 'Object', 'Game'),
('q_2_9_15', 'gen_2_9', 'Who buys goods?', 'Consumer', 'Producer', 'Seller', 'Worker'),
('q_2_9_16', 'gen_2_9', 'Who makes goods?', 'Producer', 'Consumer', 'Buyer', 'User'),
('q_2_9_17', 'gen_2_9', 'Fixing a car is a?', 'Service', 'Good', 'Part', 'Road'),
('q_2_9_18', 'gen_2_9', 'Bread from a bakery is a?', 'Good', 'Service', 'Worker', 'Recipe'),
('q_2_9_19', 'gen_2_9', 'A doctor''s visit is a?', 'Service', 'Good', 'Medicine', 'Hospital'),
('q_2_9_20', 'gen_2_9', 'A trade without money is?', 'Barter', 'Sale', 'Service', 'Gift');

-- LVL 10 SOCIAL: Government & Citizenship
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_2_10_11', 'gen_2_10', 'Who is the leader of a state?', 'Governor', 'President', 'Mayor', 'King'),
('q_2_10_12', 'gen_2_10', 'Laws are made to?', 'Keep us safe', 'Make us sad', 'Cost money', 'Waste time'),
('q_2_10_13', 'gen_2_10', 'A good citizen?', 'Helps others', 'Lutters', 'Breaks rules', 'Ignores rules'),
('q_2_10_14', 'gen_2_10', 'The capital of the USA is?', 'Washington DC', 'New York', 'Los Angeles', 'Houston'),
('q_2_10_15', 'gen_2_10', 'How do citizens choose leaders?', 'Voting', 'Guessing', 'Asking', 'Fighting'),
('q_2_10_16', 'gen_2_10', 'The document with the laws?', 'Constitution', 'Dictionary', 'Newspaper', 'Catalog'),
('q_2_10_17', 'gen_2_10', 'Who is the head of the country?', 'President', 'Mayor', 'Principal', 'Police'),
('q_2_10_18', 'gen_2_10', 'The Supreme Court is for?', 'Judging laws', 'Making laws', 'Eating', 'Playing'),
('q_2_10_19', 'gen_2_10', 'What color is the flag mostly?', 'Red, White, Blue', 'Green and Red', 'Purple and Gold', 'Black and White'),
('q_2_10_20', 'gen_2_10', 'Why do we have taxes?', 'Pay for services', 'Buy candy', 'Give gifts', 'To be mean');

-- ==========================================
-- GRADE 3: 3RD GRADE
-- Topics: Math (1-5), Science (6-8), Social (9-10)
-- ==========================================

-- LVL 1 MATH: Multiplication (Tables 0-5)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_1_11', 'gen_3_1', '3 x 4 = ?', '12', '7', '9', '15'),
('q_3_1_12', 'gen_3_1', '5 x 6 = ?', '30', '25', '35', '11'),
('q_3_1_13', 'gen_3_1', '2 x 9 = ?', '18', '11', '20', '16'),
('q_3_1_14', 'gen_3_1', '4 x 8 = ?', '32', '24', '36', '40'),
('q_3_1_15', 'gen_3_1', '0 x 100 = ?', '0', '100', '1', '10'),
('q_3_1_16', 'gen_3_1', '1 x 15 = ?', '15', '1', '16', '0'),
('q_3_1_17', 'gen_3_1', '5 x 5 = ?', '25', '20', '30', '10'),
('q_3_1_18', 'gen_3_1', '3 x 7 = ?', '21', '14', '28', '10'),
('q_3_1_19', 'gen_3_1', '4 x 4 = ?', '16', '8', '12', '20'),
('q_3_1_20', 'gen_3_1', '2 x 8 = ?', '16', '10', '18', '14');

-- LVL 2 MATH: Division Basics
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_2_11', 'gen_3_2', '12 / 3 = ?', '4', '3', '5', '9'),
('q_3_2_12', 'gen_3_2', '20 / 5 = ?', '4', '5', '15', '10'),
('q_3_2_13', 'gen_3_2', '18 / 2 = ?', '9', '8', '20', '16'),
('q_3_2_14', 'gen_3_2', '15 / 3 = ?', '5', '3', '12', '6'),
('q_3_2_15', 'gen_3_2', '24 / 4 = ?', '6', '4', '8', '20'),
('q_3_2_16', 'gen_3_2', '30 / 6 = ?', '5', '6', '10', '24'),
('q_3_2_17', 'gen_3_2', '10 / 1 = ?', '10', '1', '11', '0'),
('q_3_2_18', 'gen_3_2', '16 / 4 = ?', '4', '12', '20', '8'),
('q_3_2_19', 'gen_3_2', '25 / 5 = ?', '5', '10', '20', '1'),
('q_3_2_20', 'gen_3_2', '14 / 2 = ?', '7', '12', '16', '6');

-- LVL 3 MATH: Fractions Introduction
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_3_11', 'gen_3_3', 'What is 1/2 of 10?', '5', '2', '12', '20'),
('q_3_3_12', 'gen_3_3', 'Which fraction is half?', '1/2', '1/3', '1/4', '2/1'),
('q_3_3_13', 'gen_3_3', 'Which fraction is a quarter?', '1/4', '1/2', '4/1', '1/3'),
('q_3_3_14', 'gen_3_3', 'If you cut a pizza in 4, one piece is?', '1/4', '1/2', '1/1', '4/1'),
('q_3_3_15', 'gen_3_3', 'The bottom number of a fraction?', 'Denominator', 'Numerator', 'Total', 'Top'),
('q_3_3_16', 'gen_3_3', 'The top number of a fraction?', 'Numerator', 'Denominator', 'Bottom', 'Part'),
('q_3_3_17', 'gen_3_3', 'What is 1/4 of 8?', '2', '4', '12', '32'),
('q_3_3_18', 'gen_3_3', 'Which is bigger: 1/2 or 1/4?', '1/2', '1/4', 'Same', 'None'),
('q_3_3_19', 'gen_3_3', 'Which is smaller: 1/10 or 1/2?', '1/10', '1/2', 'Same', 'None'),
('q_3_3_20', 'gen_3_3', 'What is 2/2?', '1 whole', 'None', 'Half', 'Double');

-- LVL 4 MATH: Geometry (Polygons)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_4_11', 'gen_3_4', 'How many sides on a hexagon?', '6', '5', '8', '4'),
('q_3_4_12', 'gen_3_4', 'How many sides on an octagon?', '8', '6', '10', '5'),
('q_3_4_13', 'gen_3_4', 'A polygon with 5 sides?', 'Pentagon', 'Hexagon', 'Square', 'Triangle'),
('q_3_4_14', 'gen_3_4', 'What has 4 equal sides and 4 corners?', 'Square', 'Rectangle', 'Circle', 'Triangle'),
('q_3_4_15', 'gen_3_4', 'A triangle has how many angles?', '3', '4', '2', '5'),
('q_3_4_16', 'gen_3_4', 'Is a circle a polygon?', 'No', 'Yes', 'Only on Sundays', 'Sometimes'),
('q_3_4_17', 'gen_3_4', 'What is the sum of angles in a triangle?', '180', '90', '360', '100'),
('q_3_4_18', 'gen_3_4', 'A 4-sided polygon is a?', 'Quadrilateral', 'Triangle', 'Pentagon', 'Hexagon'),
('q_3_4_19', 'gen_3_4', 'Which has 10 sides?', 'Decagon', 'Octagon', 'Hexagon', 'Duo'),
('q_3_4_20', 'gen_3_4', 'A stop sign is which shape?', 'Octagon', 'Circle', 'Square', 'Triangle');

-- LVL 5 MATH: Area & Perimeter
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_5_11', 'gen_3_5', 'Perimeter is the?', 'Distance around', 'Space inside', 'Height', 'Weight'),
('q_3_5_12', 'gen_3_5', 'Area is the?', 'Space inside', 'Distance around', 'Color', 'Volume'),
('q_3_5_13', 'gen_3_5', 'Perimeter of a 2x3 square?', '10', '6', '5', '12'),
('q_3_5_14', 'gen_3_5', 'Area of a 2x3 square?', '6', '5', '10', '12'),
('q_3_5_15', 'gen_3_5', 'Area of a 4x4 square?', '16', '8', '12', '20'),
('q_3_5_16', 'gen_3_5', 'Perimeter of a 4x4 square?', '16', '8', '12', '20'),
('q_3_5_17', 'gen_3_5', 'Area of a 5x2 rectangle?', '10', '7', '14', '20'),
('q_3_5_18', 'gen_3_5', 'Perimeter of a 5x2 rectangle?', '14', '7', '10', '20'),
('q_3_5_19', 'gen_3_5', 'What units do we use for Area?', 'Square units', 'Long units', 'Pounds', 'Degrees'),
('q_3_5_20', 'gen_3_5', 'What is the Area if side is 1?', '1', '2', '4', '0');

-- LVL 6 SCIENCE: Ecosystems
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_6_11', 'gen_3_6', 'Who produces their own food?', 'Plants', 'Animals', 'Humans', 'Fungi'),
('q_3_6_12', 'gen_3_6', 'Who eats producers?', 'Herbivores', 'Carnivores', 'Omnivores', 'Decomposers'),
('q_3_6_13', 'gen_3_6', 'Fungi and bacteria are?', 'Decomposers', 'Producers', 'Consumers', 'Rocks'),
('q_3_6_14', 'gen_3_6', 'What is a desert ecosystem like?', 'Dry and Sparse', 'Wet and Lush', 'Cold and Snowy', 'Dark and Deep'),
('q_3_6_15', 'gen_3_6', 'What is the main energy source?', 'The Sun', 'Food', 'Water', 'Sleep'),
('q_3_6_16', 'gen_3_6', 'A food chain shows?', 'Energy flow', 'Shopping list', 'Animal friendship', 'Seasons'),
('q_3_6_17', 'gen_3_6', 'What is a swamp like?', 'Wet and Humid', 'Dry and Sandy', 'Cold and Flat', 'High and Dry'),
('q_3_6_18', 'gen_3_6', 'Predators hunt what?', 'Prey', 'Plants', 'Sun', 'Rain'),
('q_3_6_19', 'gen_3_6', 'Camouflage helps animals?', 'Hide from predators', 'Stay warm', 'Find water', 'Sleep'),
('q_3_6_20', 'gen_3_6', 'What is an omnivore?', 'Eats plants and meat', 'Eats only grass', 'Eats only lions', 'Eats only rocks');

-- LVL 7 SCIENCE: The Water Cycle
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_7_11', 'gen_3_7', 'Water turning to gas is?', 'Evaporation', 'Condensed', 'Rain', 'Freezing'),
('q_3_7_12', 'gen_3_7', 'Gas turning to liquid clouds is?', 'Condensation', 'Evaporation', 'Runoff', 'Melting'),
('q_3_7_13', 'gen_3_7', 'Rain, snow, or hail is?', 'Precipitation', 'Condensation', 'Hydration', 'Collection'),
('q_3_7_14', 'gen_3_7', 'Water running into lakes?', 'Runoff', 'Evaporation', 'Clouding', 'Freezing'),
('q_3_7_15', 'gen_3_7', 'Plants releasing water gas?', 'Transpiration', 'Breathing', 'Sweating', 'Evaporation'),
('q_3_7_16', 'gen_3_7', 'What powers the water cycle?', 'The Sun', 'Wind', 'Moon', 'Gravity'),
('q_3_7_17', 'gen_3_7', 'Where is most Earth water?', 'Oceans', 'Lakes', 'Ice', 'Pipes'),
('q_3_7_18', 'gen_3_7', 'Can we create new water?', 'No, it recycles', 'Yes, in labs', 'Only when it rains', 'In the ocean'),
('q_3_7_19', 'gen_3_7', 'Frozen water in the cycle?', 'Snow/Ice', 'Rain', 'Mist', 'Cloud'),
('q_3_7_20', 'gen_3_7', 'Underground water is called?', 'Groundwater', 'Lava', 'Dirt water', 'Ocean');

-- LVL 8 SCIENCE: Solar System
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_8_11', 'gen_3_8', 'How many planets in our system?', '8', '9', '7', '10'),
('q_3_8_12', 'gen_3_8', 'Which planet is closest to Sun?', 'Mercury', 'Venus', 'Mars', 'Earth'),
('q_3_8_13', 'gen_3_8', 'Earth takes how long to orbit?', '365 days', '24 hours', '30 days', '7 days'),
('q_3_8_14', 'gen_3_8', 'Which is the RED planet?', 'Mars', 'Jupiter', 'Venus', 'Mercury'),
('q_3_8_15', 'gen_3_8', 'Largest planet in our system?', 'Jupiter', 'Saturn', 'Neptune', 'Uranus'),
('q_3_8_16', 'gen_3_8', 'What keeps us on the ground?', 'Gravity', 'Wind', 'Glue', 'Magnets'),
('q_3_8_17', 'gen_3_8', 'The moon orbits what?', 'Earth', 'Sun', 'Mars', 'Stars'),
('q_3_8_18', 'gen_3_8', 'Which planet has big rings?', 'Saturn', 'Jupiter', 'Mars', 'Venus'),
('q_3_8_19', 'gen_3_8', 'A galaxy is a group of?', 'Stars', 'Planets', 'Moons', 'Clouds'),
('q_3_8_20', 'gen_3_8', 'Is Pluto still a major planet?', 'No (Dwarf)', 'Yes', 'It exploded', 'It moved');

-- LVL 9 SOCIAL: Geography and Maps
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_9_11', 'gen_3_9', 'Which shows North, South, East, West?', 'Compass Rose', 'Scale', 'Legend', 'Title'),
('q_3_9_12', 'gen_3_9', 'A 3D model of Earth?', 'Globe', 'Map', 'Chart', 'Picture'),
('q_3_9_13', 'gen_3_9', 'What measures distance on a map?', 'Scale', 'Legend', 'Grid', 'Compass'),
('q_3_9_14', 'gen_3_9', '0 degrees Latitude?', 'Equator', 'Prime Meridian', 'North Pole', 'South Pole'),
('q_3_9_15', 'gen_3_9', 'How many continents?', '7', '5', '6', '8'),
('q_3_9_16', 'gen_3_9', 'Largest continent?', 'Asia', 'Africa', 'Europe', 'North America'),
('q_3_9_17', 'gen_3_9', 'Which ocean borders New York?', 'Atlantic', 'Pacific', 'Indian', 'Arctic'),
('q_3_9_18', 'gen_3_9', 'Which ocean borders California?', 'Pacific', 'Atlantic', 'Indian', 'Arctic'),
('q_3_9_19', 'gen_3_9', 'Coldest continent?', 'Antarctica', 'Asia', 'Europe', 'South America'),
('q_3_9_20', 'gen_3_9', 'A map''s key is the?', 'Legend', 'Scale', 'Title', 'North');

-- LVL 10 SOCIAL: Ancient Civilizations (Basic)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_3_10_11', 'gen_3_10', 'Ancient Egyptians built?', 'Pyramids', 'Skyscrapers', 'Trains', 'Cars'),
('q_3_10_12', 'gen_3_10', 'Where was Ancient China?', 'Asia', 'Africa', 'Europe', 'America'),
('q_3_10_13', 'gen_3_10', 'Ancient Romans were in?', 'Italy', 'China', 'Egypt', 'Mexico'),
('q_3_10_14', 'gen_3_10', 'The Nile River is in?', 'Egypt', 'Greece', 'USA', 'India'),
('q_3_10_15', 'gen_3_10', 'Ancient Greeks held the first?', 'Olympics', 'Super Bowl', 'Birthday', 'Exam'),
('q_3_10_16', 'gen_3_10', 'Inventors of paper?', 'Ancient China', 'Romans', 'Greeks', 'Mayans'),
('q_3_10_17', 'gen_3_10', 'Who were the pharaohs?', 'Egyptian Kings', 'Greek gods', 'Roman soldiers', 'Farmers'),
('q_3_10_18', 'gen_3_10', 'Hieroglyphics was a form of?', 'Writing', 'Cooking', 'Dancing', 'Farming'),
('q_3_10_19', 'gen_3_10', 'The Great Wall is in?', 'China', 'Egypt', 'France', 'Brazil'),
('q_3_10_20', 'gen_3_10', 'Ancient Maya were in?', 'Central America', 'Europe', 'Asia', 'Australia');
