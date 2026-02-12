-- ==========================================
-- 4TH GRADE EXAM POPULATION (FULL VERSION)
-- Topics: Social Studies (Western Region) & Math (Unit 5)
-- ==========================================

BEGIN;

-- 1. Ensure schema is up to date (Self-healing if columns are missing)
ALTER TABLE challenges ADD COLUMN IF NOT EXISTS difficulty_level INTEGER DEFAULT 1;
ALTER TABLE challenges ADD COLUMN IF NOT EXISTS is_exam BOOLEAN DEFAULT FALSE;

-- 2. Create Challenge Records for Exams
INSERT INTO challenges (id, topic, season, week_number, grade_level, difficulty_level, is_exam) VALUES 
('exam_g4_western_region', 'Social Studies', 'Spring 2026', 1, 4, 1, TRUE),
('exam_g4_unit5_math', 'Math', 'Spring 2026', 1, 4, 1, TRUE)
ON CONFLICT (id) DO UPDATE SET is_exam = TRUE;

-- 3. Social Studies: Western Region Questions (30)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
-- Mapping & Geography
('q_ss_west_1', 'exam_g4_western_region', 'Which country borders the Western Region to the North?', 'Canada', 'Mexico', 'Russia'),
('q_ss_west_2', 'exam_g4_western_region', 'Which country borders the Western Region to the South?', 'Mexico', 'Canada', 'Brazil'),
('q_ss_west_3', 'exam_g4_western_region', 'What is the capital of Colorado?', 'Denver', 'Boulder', 'Leadville'),
('q_ss_west_4', 'exam_g4_western_region', 'Which city is known as the "City of Roses"?', 'Portland', 'Seattle', 'Boise'),
('q_ss_west_5', 'exam_g4_western_region', 'Which state is Yellowstone National Park primarily in?', 'Wyoming', 'Montana', 'Idaho'),

-- Glossary Terms
('q_ss_west_6', 'exam_g4_western_region', 'What term describes a journey made for a special purpose?', 'Expedition', 'Commute', 'Vacation'),
('q_ss_west_7', 'exam_g4_western_region', 'What is a hot spring that shoots boiling water into the air?', 'Geyser', 'Oasis', 'Gorge'),
('q_ss_west_8', 'exam_g4_western_region', 'A deep, narrow valley with steep walls is called a...?', 'Gorge', 'Pass', 'Plain'),
('q_ss_west_9', 'exam_g4_western_region', 'A place where the government makes coins is called a...?', 'Mint', 'Bank', 'Safe'),
('q_ss_west_10', 'exam_g4_western_region', 'A fertile area in a desert where water is found is an...?', 'Oasis', 'Island', 'Gorge'),

-- History & Economy
('q_ss_west_11', 'exam_g4_western_region', 'Who helped Lewis and Clark on their expedition?', 'Sacagawea', 'Columbus', 'George Washington'),
('q_ss_west_12', 'exam_g4_western_region', 'Which park was the very first National Park in the U.S.?', 'Yellowstone', 'Yosemite', 'Grand Canyon'),
('q_ss_west_13', 'exam_g4_western_region', 'Leadville, Colorado, was famous for what kind of mines?', 'Silver', 'Gold', 'Coal'),
('q_ss_west_14', 'exam_g4_western_region', 'Southern California is famous for which industry?', 'Movie Industry', 'Mining', 'Lumber'),
('q_ss_west_15', 'exam_g4_western_region', 'What is California''s Central Valley often called?', 'America''s Salad Bowl', 'The High Desert', 'Silicon Valley'),

-- Landmarks & Industry
('q_ss_west_16', 'exam_g4_western_region', 'The Columbia River Gorge forms a boundary between Oregon and...?', 'Washington', 'California', 'Idaho'),
('q_ss_west_17', 'exam_g4_western_region', 'What trail in Anchorage, Alaska, is 1,150 miles long?', 'Iditarod Trail', 'Oregon Trail', 'Santa Fe Trail'),
('q_ss_west_18', 'exam_g4_western_region', 'Waikiki Beach is a popular tourist destination in which state?', 'Hawaii', 'California', 'Washington'),
('q_ss_west_19', 'exam_g4_western_region', 'The Space Needle is a famous landmark in which city?', 'Seattle', 'Portland', 'San Francisco'),
('q_ss_west_20', 'exam_g4_western_region', 'Which city is known as the "Entertainment Capital of the World"?', 'Las Vegas', 'Hollywood', 'Denver'),

-- Cities
('q_ss_west_21', 'exam_g4_western_region', 'Why was Denver, Colorado, originally founded?', 'As a gold mining camp', 'As a religious center', 'As a movie studio'),
('q_ss_west_22', 'exam_g4_western_region', 'Which city is the "Capital of Silicon Valley" for technology?', 'San Jose', 'Boise', 'Salt Lake City'),
('q_ss_west_23', 'exam_g4_western_region', 'Salt Lake City was founded for what primary reason?', 'Religious freedom', 'To build ships', 'To mine silver'),
('q_ss_west_24', 'exam_g4_western_region', 'The Lewis and Clark trail goes through which pass in Montana?', 'Lolo Pass', 'Donner Pass', 'Mountain Pass'),
('q_ss_west_25', 'exam_g4_western_region', 'Irrigation is used in Central Valley to help what industry?', 'Farming', 'Mining', 'Software'),

-- More Facts
('q_ss_west_26', 'exam_g4_western_region', 'What is the capital of Washington state?', 'Olympia', 'Seattle', 'Tacoma'),
('q_ss_west_27', 'exam_g4_western_region', 'Which mineral was NOT mentioned as being mined in Leadville?', 'Diamonds', 'Lead', 'Zinc'),
('q_ss_west_28', 'exam_g4_western_region', 'Toursists visit Las Vegas primarily for what?', 'Tourism and Entertainment', 'Lumber', 'Agriculture'),
('q_ss_west_29', 'exam_g4_western_region', 'What is the main goal of the Iditarod sled dog race today?', 'To commemorate a life-saving mission', 'To deliver mail', 'To find gold'),
('q_ss_west_30', 'exam_g4_western_region', 'Westward Expansion describes people moving in which direction?', 'West', 'East', 'South')
ON CONFLICT (id) DO UPDATE SET
  question_text = EXCLUDED.question_text,
  correct_option = EXCLUDED.correct_option,
  wrong_option_1 = EXCLUDED.wrong_option_1,
  wrong_option_2 = EXCLUDED.wrong_option_2;

-- 4. Math: Unit 5 Geometry Questions (30)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
-- Angles
('q_math_u5_1', 'exam_g4_unit5_math', 'An angle that is exactly 90 degrees is called a...?', 'Right Angle', 'Acute Angle', 'Obtuse Angle'),
('q_math_u5_2', 'exam_g4_unit5_math', 'An angle smaller than 90 degrees is called...?', 'Acute', 'Obtuse', 'Straight'),
('q_math_u5_3', 'exam_g4_unit5_math', 'An angle larger than 90 but smaller than 180 is...?', 'Obtuse', 'Acute', 'Right'),
('q_math_u5_4', 'exam_g4_unit5_math', 'An angle that is exactly 180 degrees is a...?', 'Straight Angle', 'Right Angle', 'Turn'),
('q_math_u5_5', 'exam_g4_unit5_math', 'A tool used to measure angles is called a...?', 'Protractor', 'Ruler', 'Compass'),

-- Measuring Angles
('q_math_u5_6', 'exam_g4_unit5_math', 'Angles are measured in what unit?', 'Degrees', 'Inches', 'Centimeters'),
('q_math_u5_7', 'exam_g4_unit5_math', 'A straight angle (180 degrees) is split. One side is 67. What is the other?', '113 degrees', '123 degrees', '90 degrees'),
('q_math_u5_8', 'exam_g4_unit5_math', 'A spinner turns 20 degrees every second. How many degrees in 6 seconds?', '120 degrees', '100 degrees', '140 degrees'),
('q_math_u5_9', 'exam_g4_unit5_math', 'What fraction of a full circle is 90 degrees?', '1/4', '1/2', '1/3'),
('q_math_u5_10', 'exam_g4_unit5_math', 'What is the sum of angles that make a straight line?', '180 degrees', '90 degrees', '360 degrees'),

-- Lines
('q_math_u5_11', 'exam_g4_unit5_math', 'Lines that never cross and stay the same distance apart are...?', 'Parallel', 'Perpendicular', 'Intersecting'),
('q_math_u5_12', 'exam_g4_unit5_math', 'Lines that cross and form a 90 degree angle are...?', 'Perpendicular', 'Parallel', 'Symmetric'),
('q_math_u5_13', 'exam_g4_unit5_math', 'True or False: All perpendicular lines intersect.', 'True', 'False', 'Sometimes'),
('q_math_u5_14', 'exam_g4_unit5_math', 'True or False: All intersecting lines are perpendicular.', 'False', 'True', 'Sometimes'),
('q_math_u5_15', 'exam_g4_unit5_math', 'What do you call lines that simply cross at a point?', 'Intersecting', 'Parallel', 'Straight'),

-- Polygons & Symmetry
('q_math_u5_16', 'exam_g4_unit5_math', 'A closed shape made of straight sides is called a...?', 'Polygon', 'Circle', 'Angle'),
('q_math_u5_17', 'exam_g4_unit5_math', 'How many lines of symmetry does a rectangle usually have?', '2', '4', '1'),
('q_math_u5_18', 'exam_g4_unit5_math', 'A square has how many lines of symmetry?', '4', '2', '0'),
('q_math_u5_19', 'exam_g4_unit5_math', 'A circle has how many lines of symmetry?', 'Infinite', '1', '4'),
('q_math_u5_20', 'exam_g4_unit5_math', 'A shape that can be folded in half perfectly has...?', 'Line Symmetry', 'Parallelism', 'Area'),

-- Area & Perimeter
('q_math_u5_21', 'exam_g4_unit5_math', 'What is the formula for the Area of a rectangle?', 'Length x Width', 'Length + Width', '2L + 2W'),
('q_math_u5_22', 'exam_g4_unit5_math', 'What is the formula for the Perimeter of a rectangle?', '2L + 2W', 'L x W', 'L + W'),
('q_math_u5_23', 'exam_g4_unit5_math', 'Find the Area of a rectangle that is 7 inches by 6 inches.', '42 sq inches', '26 inches', '13 inches'),
('q_math_u5_24', 'exam_g4_unit5_math', 'Find the Perimeter of a rectangle with length 12 and width 5.', '34', '60', '17'),
('q_math_u5_25', 'exam_g4_unit5_math', 'A rectangle has Area 54 sq units. If one side is 9, what is the other?', '6', '45', '12'),

-- Advanced & Composite
('q_math_u5_26', 'exam_g4_unit5_math', 'A rectangle has Perimeter 40. One side is 12. What is the other?', '8', '14', '28'),
('q_math_u5_27', 'exam_g4_unit5_math', 'To find the Area of a composite shape, you should...?', 'Add the areas of the parts', 'Subtract the perimeters', 'Multiply everything'),
('q_math_u5_28', 'exam_g4_unit5_math', 'A shape made of two rectangles (6x4 and 3x4) has a total area of...?', '36', '24', '12'),
('q_math_u5_29', 'exam_g4_unit5_math', 'A 8x5 rectangle attached to a 4x5 rectangle has a total area of...?', '60', '40', '20'),
('q_math_u5_30', 'exam_g4_unit5_math', 'Which has a larger Perimeter: a 6x8 rectangle or a 12x4 rectangle?', '12x4 (P=32)', '6x8 (P=28)', 'They are equal')
ON CONFLICT (id) DO UPDATE SET
  question_text = EXCLUDED.question_text,
  correct_option = EXCLUDED.correct_option,
  wrong_option_1 = EXCLUDED.wrong_option_1,
  wrong_option_2 = EXCLUDED.wrong_option_2;

COMMIT;
