-- Batch 4: Grade 4 (4th Grade) and Grade 5 (5th Grade)
-- Adding 10 new questions per challenge (Total 200 questions)

-- ==========================================
-- GRADE 4: 4TH GRADE
-- Topics: Math (1-5), Science (6-8), Social (9-10)
-- ==========================================

-- LVL 1 MATH: Multiplication and Factors
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_1_11', 'gen_4_1', 'What are factors of 12?', '1, 2, 3, 4, 6, 12', '1, 2, 12', '3, 4, 8', '2, 4, 6, 10'),
('q_4_1_12', 'gen_4_1', 'Is 17 a prime number?', 'Yes', 'No', 'Sometimes', 'I don''t know'),
('q_4_1_13', 'gen_4_1', 'First 5 multiples of 4?', '4, 8, 12, 16, 20', '4, 6, 8, 10, 12', '1, 2, 3, 4, 5', '4, 8, 16, 32, 64'),
('q_4_1_14', 'gen_4_1', 'What is 12 x 11?', '132', '121', '144', '110'),
('q_4_1_15', 'gen_4_1', 'What is 15 x 6?', '90', '75', '80', '100'),
('q_4_1_16', 'gen_4_1', 'Which is a multiple of 9?', '27', '21', '32', '19'),
('q_4_1_17', 'gen_4_1', 'What is the product of 25 and 4?', '100', '75', '125', '50'),
('q_4_1_18', 'gen_4_1', 'Is 25 a prime number?', 'No (5x5)', 'Yes', 'Only on Tuesdays', 'Always'),
('q_4_1_19', 'gen_4_1', 'Factors of 7?', '1, 7', '1, 2, 7', '7, 14', '0, 7'),
('q_4_1_20', 'gen_4_1', 'What is 8 x 7?', '56', '54', '64', '49');

-- LVL 2 MATH: Long Division and Place Value
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_2_11', 'gen_4_2', '100 / 4 = ?', '25', '20', '50', '40'),
('q_4_2_12', 'gen_4_2', 'Value of 7 in 7,432?', '7000', '700', '70', '7'),
('q_4_2_13', 'gen_4_2', '144 / 12 = ?', '12', '14', '10', '16'),
('q_4_2_14', 'gen_4_2', 'What is the remainder of 10 / 3?', '1', '0', '2', '3'),
('q_4_2_15', 'gen_4_2', '600 / 6 = ?', '100', '60', '10', '600'),
('q_4_2_16', 'gen_4_2', 'Place value of 5 in 1.5?', 'Tenths', 'Hundreds', 'Ones', 'Tens'),
('q_4_2_17', 'gen_4_2', '99 / 9 = ?', '11', '9', '10', '12'),
('q_4_2_18', 'gen_4_2', 'What is 1,000 x 5?', '5,000', '500', '50', '50,000'),
('q_4_2_19', 'gen_4_2', '240 / 8 = ?', '30', '40', '20', '60'),
('q_4_2_20', 'gen_4_2', 'Value of 2 in 0.02?', 'Hundredths', 'Tenths', 'Ones', 'Tens');

-- LVL 3 MATH: Fractions and Decimals
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_3_11', 'gen_4_3', 'Equivalent to 1/2?', '2/4', '1/3', '2/2', '1/4'),
('q_4_3_12', 'gen_4_3', 'What is 0.5 as a fraction?', '1/2', '1/5', '1/4', '5/1'),
('q_4_3_13', 'gen_4_3', 'Which is larger: 0.7 or 0.3?', '0.7', '0.3', 'Same', 'None'),
('q_4_3_14', 'gen_4_3', 'Simplify 4/8?', '1/2', '2/4', '1/4', '4/1'),
('q_4_3_15', 'gen_4_3', 'What is 0.25 as a fraction?', '1/4', '1/5', '1/2', '2/5'),
('q_4_3_16', 'gen_4_3', 'Compare: 1/4 and 2/8?', 'Equal', '1/4 is bigger', '2/8 is bigger', 'None'),
('q_4_3_17', 'gen_4_3', 'Convert 3/10 to decimal?', '0.3', '3.0', '0.03', '30'),
('q_4_3_18', 'gen_4_3', 'Convert 0.75 to fraction?', '3/4', '1/4', '1/2', '7/5'),
('q_4_3_19', 'gen_4_3', 'Add 1/4 + 1/4?', '2/4 (1/2)', '2/8', '1/8', '1/2'),
('q_4_3_20', 'gen_4_3', 'What is 1.0 - 0.5?', '0.5', '1.5', '0.1', '1.0');

-- LVL 4 MATH: Geometry (Angles)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_4_11', 'gen_4_4', 'An angle of 90 degrees is?', 'Right', 'Acute', 'Obtuse', 'Straight'),
('q_4_4_12', 'gen_4_4', 'An angle less than 90 is?', 'Acute', 'Obtuse', 'Right', 'Reflex'),
('q_4_4_13', 'gen_4_4', 'An angle greater than 90 is?', 'Obtuse', 'Acute', 'Right', 'Straight'),
('q_4_4_14', 'gen_4_4', 'A flat angle (180 deg) is?', 'Straight', 'Right', 'Round', 'Obtuse'),
('q_4_4_15', 'gen_4_4', 'Degree of a full circle?', '360', '180', '90', '100'),
('q_4_4_16', 'gen_4_4', 'Lines that never meet?', 'Parallel', 'Perpendicular', 'Intersecting', 'Diagonal'),
('q_4_4_17', 'gen_4_4', 'Lines that meet at 90 deg?', 'Perpendicular', 'Parallel', 'Straight', 'Wave'),
('q_4_4_18', 'gen_4_4', 'A triangle with 3 equal sides?', 'Equilateral', 'Isosceles', 'Scalene', 'Right'),
('q_4_4_19', 'gen_4_4', 'A triangle with no equal sides?', 'Scalene', 'Isosceles', 'Equilateral', 'Acute'),
('q_4_4_20', 'gen_4_4', 'Sum of angles in a rectangle?', '360', '180', '90', '400');

-- LVL 5 MATH: Conversions and Units
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_5_11', 'gen_4_5', 'How many feet in a yard?', '3', '12', '1', '10'),
('q_4_5_12', 'gen_4_5', 'How many inches in a foot?', '12', '10', '3', '36'),
('q_4_5_13', 'gen_4_5', 'How many ounces in a pound?', '16', '12', '10', '32'),
('q_4_5_14', 'gen_4_5', 'How many grams in a kilogram?', '1000', '100', '10', '10,000'),
('q_4_5_15', 'gen_4_5', 'How many milliliters in a liter?', '1000', '100', '10', '10,000'),
('q_4_5_16', 'gen_4_5', 'Boiling point of water (Celsius)?', '100', '0', '32', '212'),
('q_4_5_17', 'gen_4_5', 'Freezing point of water (Celsius)?', '0', '100', '32', '-10'),
('q_4_5_18', 'gen_4_5', 'How many cm in 1 meter?', '100', '10', '1000', '12'),
('q_4_5_19', 'gen_4_5', 'How many seconds in a minute?', '60', '30', '100', '12'),
('q_4_5_20', 'gen_4_5', 'How many minutes in an hour?', '60', '24', '100', '12');

-- LVL 6 SCIENCE: Food Chains & Webs
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_6_11', 'gen_4_6', 'Who is at the start of most food chains?', 'Producers (Sun/Plants)', 'Lions', 'Humans', 'Fungi'),
('q_4_6_12', 'gen_4_6', 'An animal that only eats plants?', 'Herbivore', 'Carnivore', 'Omnivore', 'Decomposer'),
('q_4_6_13', 'gen_4_6', 'An animal that only eats meat?', 'Carnivore', 'Herbivore', 'Producer', 'Plant'),
('q_4_6_14', 'gen_4_6', 'What is a food web?', 'Linked food chains', 'A spider web', 'A menu', 'A game'),
('q_4_6_15', 'gen_4_6', 'What breaks down dead matter?', 'Decomposers', 'Producers', 'Apex predators', 'Rocks'),
('q_4_6_16', 'gen_4_6', 'A hawk is usually a?', 'Tertiary consumer', 'Primary producer', 'Flower', 'Mineral'),
('q_4_6_17', 'gen_4_6', 'Grass is a?', 'Producer', 'Consumer', 'Decomposer', 'Slayer'),
('q_4_6_18', 'gen_4_6', 'The first consumer in a chain is a?', 'Primary consumer', 'Secondary consumer', 'Third consumer', 'Chef'),
('q_4_6_19', 'gen_4_6', 'An animal that eats both?', 'Omnivore', 'Carnivore', 'Herbivore', 'Alien'),
('q_4_6_20', 'gen_4_6', 'Where do producers get energy?', 'Photosynthesis (Sun)', 'Eating bugs', 'Sleeping', 'Drinking milk');

-- LVL 7 SCIENCE: States of Matter (Cycles)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_7_11', 'gen_4_7', 'Matter turning from solid to liquid?', 'Melting', 'Freezing', 'Evaporating', 'Breathing'),
('q_4_7_12', 'gen_4_7', 'Matter turning from liquid to gas?', 'Evaporation', 'Condensation', 'Melting', 'Freezing'),
('q_4_7_13', 'gen_4_7', 'Gas turning into liquid?', 'Condensation', 'Melting', 'Flowing', 'Growing'),
('q_4_7_14', 'gen_4_7', 'Matter with NO definite shape or volume?', 'Gas', 'Liquid', 'Solid', 'Brick'),
('q_4_7_15', 'gen_4_7', 'Matter with definite volume but no shape?', 'Liquid', 'Solid', 'Gas', 'Rock'),
('q_4_7_16', 'gen_4_7', 'What defines a solid?', 'Fixed shape and volume', 'Takes container shape', 'No volume', 'Floating'),
('q_4_7_17', 'gen_4_7', 'What is sublimation?', 'Solid to Gas', 'Liquid to Gas', 'Ice to Water', 'Gas to Solid'),
('q_4_7_18', 'gen_4_7', 'Water vapor is a?', 'Gas', 'Liquid', 'Solid', 'Ice'),
('q_4_7_19', 'gen_4_7', 'Are all things on Earth matter?', 'Yes (if they have mass)', 'No', 'Only rocks', 'Only air'),
('q_4_7_20', 'gen_4_7', 'Does air have mass?', 'Yes', 'No', 'Only when windy', 'I don''t know');

-- LVL 8 SCIENCE: Energy and Electricity
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_8_11', 'gen_4_8', 'Energy of motion?', 'Kinetic', 'Potential', 'Static', 'Sound'),
('q_4_8_12', 'gen_4_8', 'Stored energy?', 'Potential', 'Kinetic', 'Heat', 'Light'),
('q_4_8_13', 'gen_4_8', 'Flow of electrons?', 'Electricity', 'Water', 'Wind', 'Sound'),
('q_4_8_14', 'gen_4_8', 'Material that electricity flows through?', 'Conductor', 'Insulator', 'Wood', 'Rubber'),
('q_4_8_15', 'gen_4_8', 'Material that STOPS electricity?', 'Insulator', 'Conductor', 'Metal', 'Water'),
('q_4_8_16', 'gen_4_8', 'A path for electricity?', 'Circuit', 'Road', 'Pipe', 'Wire'),
('q_4_8_17', 'gen_4_8', 'What is renewable energy?', 'Can be replaced (Sun/Wind)', 'Can never be replaced', 'Batteries only', 'Wood'),
('q_4_8_18', 'gen_4_8', 'Unit to measure energy in food?', 'Calories', 'Degrees', 'Volts', 'Watts'),
('q_4_8_19', 'gen_4_8', 'Solar energy comes from?', 'The Sun', 'Coal', 'Ocean', 'Wind'),
('q_4_8_20', 'gen_4_8', 'What is friction?', 'Force that slows things', 'A type of gas', 'Energy of heat', 'Magnetism');

-- LVL 9 SOCIAL: Geography and Regions
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_9_11', 'gen_4_9', 'Tallest mountain on Earth?', 'Mt. Everest', 'Kilimanjaro', 'Whitney', 'Rainier'),
('q_4_9_12', 'gen_4_9', 'Longest river in the world?', 'Nile (or Amazon)', 'Mississippi', 'Yangtze', 'Hudson'),
('q_4_9_13', 'gen_4_9', 'Largest desert?', 'Sahara (or Antarctic)', 'Mojave', 'Gobi', 'Sonoran'),
('q_4_9_14', 'gen_4_9', 'Imaginary line around Earth''s center?', 'Equator', 'Prime Meridian', 'North Pole', 'Belt'),
('q_4_9_15', 'gen_4_9', 'Half of the Earth?', 'Hemisphere', 'Continent', 'Island', 'Circle'),
('q_4_9_16', 'gen_4_9', 'How many continents?', '7', '5', '10', '4'),
('q_4_9_17', 'gen_4_9', 'Largest ocean?', 'Pacific', 'Atlantic', 'Arctic', 'Indian'),
('q_4_9_18', 'gen_4_9', 'Which region is usually coldest?', 'Tundra/Arctic', 'Tropics', 'Desert', 'Plains'),
('q_4_9_19', 'gen_4_9', 'Where is the Bayou primarily?', 'Gulf Coast (Louisiana/TX)', 'California', 'Maine', 'Alaska'),
('q_4_9_20', 'gen_4_9', 'A marshy area of water?', 'Swamp or Bayou', 'Mountain', 'Volcano', 'Glacier');

-- LVL 10 SOCIAL: Government and Civics
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_4_10_11', 'gen_4_10', 'Number of branches in US Gov?', '3', '2', '4', '1'),
('q_4_10_12', 'gen_4_10', 'Which branch MAKES laws?', 'Legislative (Congress)', 'Executive', 'Judicial', 'Army'),
('q_4_10_13', 'gen_4_10', 'Which branch ENFORCES laws?', 'Executive (President)', 'Legislative', 'Judicial', 'Police'),
('q_4_10_14', 'gen_4_10', 'Which branch JUDGES laws?', 'Judicial (Courts)', 'Legislative', 'Executive', 'Library'),
('q_4_10_15', 'gen_4_10', 'Highest court in the land?', 'Supreme Court', 'Traffic Court', 'State Court', 'Judge Shop'),
('q_4_10_16', 'gen_4_10', 'First 10 amendments?', 'Bill of Rights', 'Constitution', 'Rule Book', 'Menu'),
('q_4_10_17', 'gen_4_10', 'Freedom of speech is in?', '1st Amendment', '2nd Amendment', 'Constitution', 'History book'),
('q_4_10_18', 'gen_4_10', 'Who is the Commander in Chief?', 'The President', 'The Mayor', 'The General', 'Ernie'),
('q_4_10_19', 'gen_4_10', 'How many senators per state?', '2', '1', '10', '50'),
('q_4_10_20', 'gen_4_10', 'How often do we elect a President?', '4 years', '2 years', 'Every year', '8 years');

-- ==========================================
-- GRADE 5: 5TH GRADE
-- Topics: Math (1-5), Science (6-8), Social (9-10)
-- ==========================================

-- LVL 1 MATH: Order of Operations (PEMDAS)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_1_11', 'gen_5_1', '5 + 2 x 3 = ?', '11', '21', '13', '10'),
('q_5_1_12', 'gen_5_1', '(4 + 2) x 5 = ?', '30', '14', '22', '24'),
('q_5_1_13', 'gen_5_1', '10 / 2 + 3 = ?', '8', '2', '5', '10'),
('q_5_1_14', 'gen_5_1', '20 - 5 x 2 = ?', '10', '30', '0', '15'),
('q_5_1_15', 'gen_5_1', '3 x (4 + 6) = ?', '30', '18', '22', '12'),
('q_5_1_16', 'gen_5_1', '8 + 12 / 4 = ?', '11', '5', '20', '8'),
('q_5_1_17', 'gen_5_1', 'PEMDAS: P stands for?', 'Parentheses', 'Point', 'Plus', 'Parallel'),
('q_5_1_18', 'gen_5_1', 'PEMDAS: E stands for?', 'Exponents', 'Equal', 'Equation', 'Even'),
('q_5_1_19', 'gen_5_1', '10 x 2 + 5 = ?', '25', '70', '20', '30'),
('q_5_1_20', 'gen_5_1', '15 / (3 + 2) = ?', '3', '7', '10', '5');

-- LVL 2 MATH: Decimals and Millions
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_2_11', 'gen_5_2', '0.25 + 0.50 = ?', '0.75', '0.30', '0.55', '1.00'),
('q_5_2_12', 'gen_5_2', '1,000,000 has how many zeros?', '6', '5', '7', '4'),
('q_5_2_13', 'gen_5_2', '0.1 x 10 = ?', '1', '0.1', '10', '0.01'),
('q_5_2_14', 'gen_5_2', 'What is 0.75 as a percent?', '75%', '7.5%', '0.75%', '750%'),
('q_5_2_15', 'gen_5_2', 'Compare: 0.8 and 0.08?', '0.8 is larger', '0.08 is larger', 'Same', 'None'),
('q_5_2_16', 'gen_5_2', '1.25 x 4 = ?', '5', '4', '4.5', '6'),
('q_5_2_17', 'gen_5_2', 'Round 3.45 to tenths?', '3.5', '3.4', '4.0', '3.0'),
('q_5_2_18', 'gen_5_2', '10.5 / 2 = ?', '5.25', '5.5', '5.1', '5.75'),
('q_5_2_19', 'gen_5_2', '0.9 - 0.45 = ?', '0.45', '0.55', '0.50', '0.40'),
('q_5_2_20', 'gen_5_2', 'How many tens in a million?', '100,000', '10,000', '1,000,000', '1,000');

-- LVL 3 MATH: Fractions (Mixed & Improper)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_3_11', 'gen_5_3', 'Convert 3/2 to a mixed number?', '1 1/2', '2 1/3', '1 1/3', '3 1/2'),
('q_5_3_12', 'gen_5_3', 'Add 1/2 + 1/4 = ?', '3/4', '2/6', '2/4', '1/2'),
('q_5_3_13', 'gen_5_3', 'Add 1/3 + 1/3 = ?', '2/3', '1/6', '1/9', '1/2'),
('q_5_3_14', 'gen_5_3', 'What is 5/5?', '1 whole', '5 wholes', 'None', 'Half'),
('q_5_3_15', 'gen_5_3', 'Which is largest: 1/2, 2/3, 3/4?', '3/4', '2/3', '1/2', 'Same'),
('q_5_3_16', 'gen_5_3', 'Subtract 3/4 - 1/4 = ?', '2/4 (1/2)', '2/0', '4/4', '1/4'),
('q_5_3_17', 'gen_5_3', 'Convert 1 1/4 to improper?', '5/4', '4/4', '1/4', '2/4'),
('q_5_3_18', 'gen_5_3', 'Multiply 1/2 x 1/2?', '1/4', '1/2', '2/4', '1/1'),
('q_5_3_19', 'gen_5_3', 'What is 10/2?', '5', '2', '20', '1'),
('q_5_3_20', 'gen_5_3', 'Common denominator of 1/2 and 1/3?', '6', '5', '2', '3');

-- LVL 4 MATH: Volumetric Calculations (3D)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_4_11', 'gen_5_4', 'Volume of a 2x3x4 prism?', '24', '12', '9', '20'),
('q_5_4_12', 'gen_5_4', 'Formula for Volume?', 'L x W x H', 'L + W + H', 'Area x 2', 'L x W'),
('q_5_4_13', 'gen_5_4', 'Units for volume?', 'Cubic units', 'Square units', 'Linear units', 'Degrees'),
('q_5_4_14', 'gen_5_4', 'A cube with side 2 has volume?', '8', '4', '6', '12'),
('q_5_4_15', 'gen_5_4', 'Area of base x height = ?', 'Volume', 'Perimeter', 'Surface Area', 'Weight'),
('q_5_4_16', 'gen_5_4', 'Volume of a 5x1x2 prism?', '10', '8', '12', '20'),
('q_5_4_17', 'gen_5_4', 'How many faces on a cube?', '6', '8', '4', '12'),
('q_5_4_18', 'gen_5_4', 'How many corners (vertices) on a cube?', '8', '6', '12', '4'),
('q_5_4_19', 'gen_5_4', 'A prism with 0x4x5 has volume?', '0', '20', '9', '100'),
('q_5_4_20', 'gen_5_4', 'A box full of 1-unit cubes?', 'Volume count', 'Weight count', 'Mass count', 'Temperature');

-- LVL 5 MATH: Data and Graphs
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_5_11', 'gen_5_5', 'Average of 2, 4, 6?', '4', '12', '6', '3'),
('q_5_5_12', 'gen_5_5', 'Middle number in a sorted list?', 'Median', 'Mean', 'Mode', 'Range'),
('q_5_5_13', 'gen_5_5', 'Number that appears most?', 'Mode', 'Mean', 'Median', 'Total'),
('q_5_5_14', 'gen_5_5', 'Difference between high and low?', 'Range', 'Mean', 'Total', 'Average'),
('q_5_5_15', 'gen_5_5', 'X-axis on a graph is?', 'Horizontal', 'Vertical', 'Diagonal', 'Round'),
('q_5_5_16', 'gen_5_5', 'Y-axis on a graph is?', 'Vertical', 'Horizontal', 'Flat', 'Point'),
('q_5_5_17', 'gen_5_5', 'The point (0,0)?', 'Origin', 'Corner', 'End', 'Center'),
('q_5_5_18', 'gen_5_5', 'Representing data with dots on line?', 'Line Plot', 'Pie Chart', 'Bar Chart', 'Photo'),
('q_5_5_19', 'gen_5_5', 'Representing data with bars?', 'Bar Graph', 'Pie Chart', 'List', 'Story'),
('q_5_5_20', 'gen_5_5', 'Average is also called?', 'Mean', 'Median', 'Mode', 'Sum');

-- LVL 6 SCIENCE: Human Body Systems
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_6_11', 'gen_5_6', 'System that pumps blood?', 'Circulatory', 'Skeletal', 'Digestive', 'Nervous'),
('q_5_6_12', 'gen_5_6', 'System for breathing?', 'Respiratory', 'Muscular', 'Nervous', 'Skeletal'),
('q_5_6_13', 'gen_5_6', 'Main control center?', 'Brain (Nervous)', 'Heart', 'Stomach', 'Bone'),
('q_5_6_14', 'gen_5_6', 'System that breaks down food?', 'Digestive', 'Circulatory', 'Respiratory', 'Skin'),
('q_5_6_15', 'gen_5_6', 'Supports and protects the body?', 'Skeletal', 'Muscular', 'Nervous', 'Fat'),
('q_5_6_16', 'gen_5_6', 'Helps the body move?', 'Muscular', 'Skeletal', 'Digestive', 'Skin'),
('q_5_6_17', 'gen_5_6', 'Where is the femur?', 'Leg', 'Arm', 'Head', 'Hand'),
('q_5_6_18', 'gen_5_6', 'What protects the brain?', 'Skull', 'Ribs', 'Skin', 'Hair'),
('q_5_6_19', 'gen_5_6', 'Blood carries which gas to cells?', 'Oxygen', 'Carbon Dioxide', 'Helium', 'Smoke'),
('q_5_6_20', 'gen_5_6', 'Largest organ of the body?', 'Skin', 'Heart', 'Brain', 'Lungs');

-- LVL 7 SCIENCE: Earth''s Systems (Atmos/Geo)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_7_11', 'gen_5_7', 'Air surrounding Earth?', 'Atmosphere', 'Geosphere', 'Biosphere', 'Hydrosphere'),
('q_5_7_12', 'gen_5_7', 'All water on Earth?', 'Hydrosphere', 'Atmosphere', 'Space', 'Clouds'),
('q_5_7_13', 'gen_5_7', 'Inner core of Earth?', 'Solid Metal', 'Liquid lava', 'Air', 'Dirt'),
('q_5_7_14', 'gen_5_7', 'Process of breaking rocks?', 'Weathering', 'Seeding', 'Growing', 'Farming'),
('q_5_7_15', 'gen_5_7', 'Movement of sediment?', 'Erosion', 'Gravity', 'Freezing', 'Melting'),
('q_5_7_16', 'gen_5_7', 'Layers of the atmosphere closest to us?', 'Troposphere', 'Stratosphere', 'Exosphere', 'Space'),
('q_5_7_17', 'gen_5_7', 'What gas do humans need?', 'Oxygen', 'Nitrogen', 'Argon', 'Neon'),
('q_5_7_18', 'gen_5_7', 'What gas makes up most of air?', 'Nitrogen', 'Oxygen', 'Magic', 'Cloud'),
('q_5_7_19', 'gen_5_7', 'Slow moving river of ice?', 'Glacier', 'Cloud', 'River', 'Puddle'),
('q_5_7_20', 'gen_5_7', 'Thin layer of life on Earth?', 'Biosphere', 'Geo', 'Atmos', 'Hydro');

-- LVL 8 SCIENCE: Outer Space and Gravity
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_8_11', 'gen_5_8', 'Force that keeps planets in orbit?', 'Gravity', 'Wind', 'Magnetism', 'Magic'),
('q_5_8_12', 'gen_5_8', 'Planet with the most moons?', 'Saturn (or Jupiter)', 'Mars', 'Earth', 'Venus'),
('q_5_8_13', 'gen_5_8', 'Small rocky bodies orbiting Sun?', 'Asteroids', 'Stars', 'Planets', 'Clouds'),
('q_5_8_14', 'gen_5_8', 'Dirty snowballs in space?', 'Comets', 'Stars', 'Stars', 'Stars'),
('q_5_8_15', 'gen_5_8', 'Center of our solar system?', 'The Sun', 'Earth', 'Jupiter', 'The Moon'),
('q_5_8_16', 'gen_5_8', 'Distance traveled by light in 1 year?', 'Light year', 'Mile', 'Kilometer', 'Gallon'),
('q_5_8_17', 'gen_5_8', 'Huge system of stars/dust/gas?', 'Galaxy', 'System', 'Room', 'School'),
('q_5_8_18', 'gen_5_8', 'Is weight the same as mass?', 'No (weight depends on gravity)', 'Yes', 'Only on Earth', 'Never'),
('q_5_8_19', 'gen_5_8', 'Force of Earth on Moon?', 'Gravity', 'Wind', 'Push', 'Pull'),
('q_5_8_20', 'gen_5_8', 'How many moons does Earth have?', '1', '2', '0', 'Many');

-- LVL 9 SOCIAL: US History (Colonial - Rev)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_9_11', 'gen_5_9', 'First permanent English settlement?', 'Jamestown', 'Plymouth', 'Roanoke', 'New York'),
('q_5_9_12', 'gen_5_9', 'Colonists who wanted freedom?', 'Patriots', 'Loyalists', 'Redcoats', 'Kings'),
('q_5_9_13', 'gen_5_9', 'Date of Declaration of Indep?', 'July 4, 1776', 'Oct 12, 1492', 'Dec 25, 1800', 'Jan 1, 1901'),
('q_5_9_14', 'gen_5_9', 'Who wrote the Declaration?', 'Thomas Jefferson', 'George Washington', 'Ernie', 'King George'),
('q_5_9_15', 'gen_5_9', 'War for US Independence?', 'Revolutionary War', 'Civil War', 'WWI', 'War of 1812'),
('q_5_9_16', 'gen_5_9', 'Who won the Revolutionary War?', 'The Colonies (USA)', 'Great Britain', 'France', 'Spain'),
('q_5_9_17', 'gen_5_9', 'Colony for religious freedom?', 'Plymouth (Pilgrims)', 'Jamestown', 'Virginia', 'Georgia'),
('q_5_9_18', 'gen_5_9', 'Leader of the Continental Army?', 'George Washington', 'TJ', 'MLK', 'Lincoln'),
('q_5_9_19', 'gen_5_9', 'Thirteen colonies were on?', 'East Coast', 'West Coast', 'Gulf Coast', 'Mountains'),
('q_5_9_20', 'gen_5_9', 'Tea tossed into harbor event?', 'Boston Tea Party', 'Beach Party', 'Dinner Party', 'Exam Day');

-- LVL 10 SOCIAL: Civil War and Beyond
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_5_10_11', 'gen_5_10', 'War between North and South?', 'Civil War', 'Revolutionary War', 'WWI', 'Cold War'),
('q_5_10_12', 'gen_5_10', 'President during Civil War?', 'Abraham Lincoln', 'Washington', 'Jefferson', 'Grant'),
('q_5_10_13', 'gen_5_10', 'Document that freed slaves?', 'Emancipation Proclamation', 'Constitution', 'Treaty', 'Recipe'),
('q_5_10_14', 'gen_5_10', 'Winner of the Civil War?', 'The North (Union)', 'The South', 'Great Britain', 'France'),
('q_5_10_15', 'gen_5_10', 'Civil Rights leader had a dream?', 'MLK Jr.', 'Malcolm X', 'Rosa Parks', 'Lincoln'),
('q_5_10_16', 'gen_5_10', 'Refused to give up bus seat?', 'Rosa Parks', 'MLK', 'Susan B. Anthony', 'Lincoln'),
('q_5_10_17', 'gen_5_10', 'Fought for women''s right to vote?', 'Susan B. Anthony', 'MLK', 'Washington', 'Ernie'),
('q_5_10_18', 'gen_5_10', 'Amendment that gave women vote?', '19th Amendment', '1st', '10th', '100th'),
('q_5_10_19', 'gen_5_10', 'Capital of the Confederacy?', 'Richmond, VA', 'Washington DC', 'Montgomery', 'Atlanta'),
('q_5_10_20', 'gen_5_10', 'Gettysburg Address was a?', 'Speech by Lincoln', 'House', 'Letter', 'Law');
