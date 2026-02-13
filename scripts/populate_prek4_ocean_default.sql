-- ========================================================
-- PRE-K 4 (Grade -1) DEFAULT POOL: OCEAN ANIMALS & HABITATS
-- 30 Questions across 10 Difficulty Levels
-- ========================================================

BEGIN;

-- 1. Create Challenge Records (Difficulty 1-10)
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam) VALUES 
('ch_prek4_ocean_d1', 'Ocean', -1, 1, FALSE),
('ch_prek4_ocean_d2', 'Ocean', -1, 2, FALSE),
('ch_prek4_ocean_d3', 'Ocean', -1, 3, FALSE),
('ch_prek4_ocean_d4', 'Ocean', -1, 4, FALSE),
('ch_prek4_ocean_d5', 'Ocean', -1, 5, FALSE),
('ch_prek4_ocean_d6', 'Ocean', -1, 6, FALSE),
('ch_prek4_ocean_d7', 'Ocean', -1, 7, FALSE),
('ch_prek4_ocean_d8', 'Ocean', -1, 8, FALSE),
('ch_prek4_ocean_d9', 'Ocean', -1, 9, FALSE),
('ch_prek4_ocean_d10', 'Ocean', -1, 10, FALSE)
ON CONFLICT (id) DO UPDATE SET 
  topic = EXCLUDED.topic,
  is_exam = FALSE;

-- 2. Questions (30 Total)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
-- Difficulty 1: Basics
('q_prek4_p1_1', 'ch_prek4_ocean_d1', 'What animal has 8 arms and lives in the ocean?', 'Octopus', 'Cat', 'Bird'),
('q_prek4_p1_2', 'ch_prek4_ocean_d1', 'What is the big blue water called?', 'Ocean', 'Forest', 'Park'),
('q_prek4_p1_3', 'ch_prek4_ocean_d1', 'Which ocean animal is very, very big?', 'Whale', 'Ant', 'Mouse'),

-- Difficulty 2: Motion
('q_prek4_p2_1', 'ch_prek4_ocean_d2', 'Does a fish float or sink in the ocean?', 'Float and Swim', 'Fly', 'Walk'),
('q_prek4_p2_2', 'ch_prek4_ocean_d2', 'What do fish use to swim through the water?', 'Fins', 'Wings', 'Legs'),
('q_prek4_p2_3', 'ch_prek4_ocean_d2', 'Where do waves come to the land?', 'The Beach', 'The Kitchen', 'The School'),

-- Difficulty 3: Features
('q_prek4_p3_1', 'ch_prek4_ocean_d3', 'What animal has a hard shell and crawls on the shore?', 'Crab', 'Rabbit', 'Butterfly'),
('q_prek4_p3_2', 'ch_prek4_ocean_d3', 'What colorful hard things grow in a reef?', 'Coral', 'Grass', 'Flowers'),
('q_prek4_p3_3', 'ch_prek4_ocean_d3', 'What is the sandy place next to the ocean?', 'Shore or Beach', 'Garden', 'Bedroom'),

-- Difficulty 4: Concepts
('q_prek4_p4_1', 'ch_prek4_ocean_d4', 'What is a place where an animal lives called?', 'Habitat', 'House', 'Box'),
('q_prek4_p4_2', 'ch_prek4_ocean_d4', 'What goes up and down with the ocean water?', 'The Tide', 'The Sun', 'A Ball'),
('q_prek4_p4_3', 'ch_prek4_ocean_d4', 'Is the ocean water sweet or salty?', 'Salty', 'Chocolate', 'Sour'),

-- Difficulty 5: Identification 2
('q_prek4_p5_1', 'ch_prek4_ocean_d5', 'Which animal has a long nose and jumps out of the waves?', 'Dolphin', 'Pig', 'Lion'),
('q_prek4_p5_2', 'ch_prek4_ocean_d5', 'What is the name for the top of the ocean water?', 'Surface', 'Bottom', 'Side'),
('q_prek4_p5_3', 'ch_prek4_ocean_d5', 'What animal looks like a horse but lives in the sea?', 'Seahorse', 'Donkey', 'Zebra'),

-- Difficulty 6: Care & Conservation
('q_prek4_p6_1', 'ch_prek4_ocean_d6', 'Should we throw trash in the sea?', 'No, keep it clean', 'Yes', 'Only on Tuesdays'),
('q_prek4_p6_2', 'ch_prek4_ocean_d6', 'What can we do with a plastic bottle to help?', 'Recycle it', 'Throw it away', 'Hide it'),
('q_prek4_p6_3', 'ch_prek4_ocean_d6', 'Pollution makes the ocean water...?', 'Dirty', 'Clean', 'Sparkly'),

-- Difficulty 7: Tiny Creatures
('q_prek4_p7_1', 'ch_prek4_ocean_d7', 'What tiny animal starts life as an egg in the tide pool?', 'Sea Snail', 'Puppy', 'Kitten'),
('q_prek4_p7_2', 'ch_prek4_ocean_d7', 'What animal has 5 arms and is shaped like a star?', 'Starfish', 'Squarefish', 'Moonfish'),
('q_prek4_p7_3', 'ch_prek4_ocean_d7', 'Where can we find small animals when the tide goes out?', 'Tide Pools', 'The Clouds', 'The Tree'),

-- Difficulty 8: Ecosystems
('q_prek4_p8_1', 'ch_prek4_ocean_d8', 'What do we call an animal that hunts others for food?', 'Predator', 'Friend', 'Helper'),
('q_prek4_p8_2', 'ch_prek4_ocean_d8', 'What do we call an animal that is being hunted?', 'Prey', 'Predator', 'Hunter'),
('q_prek4_p8_3', 'ch_prek4_ocean_d8', 'Big fish eat small fish. Is the big fish the predator?', 'Yes', 'No', 'Maybe'),

-- Difficulty 9: Deep Sea
('q_prek4_p9_1', 'ch_prek4_ocean_d9', 'Is it light or dark in the very deep ocean?', 'Very Dark', 'Very Bright', 'Rainbow'),
('q_prek4_p9_2', 'ch_prek4_ocean_d9', 'What animal carries its house on its back in the ocean?', 'Sea Turtle', 'Elephant', 'Giraffe'),
('q_prek4_p9_3', 'ch_prek4_ocean_d9', 'What do sharks use to breathe underwater?', 'Gills', 'Nose', 'Lungs'),

-- Difficulty 10: Review & Clean
('q_prek4_p10_1', 'ch_prek4_ocean_d10', 'How can we help the fish stay happy?', 'Keep the water clean', 'Splash them', 'Throw rocks'),
('q_prek4_p10_2', 'ch_prek4_ocean_d10', 'Everything in the ocean is part of a...?', 'Habitat', 'Game', 'Toy Box'),
('q_prek4_p10_3', 'ch_prek4_ocean_d10', 'The ocean is home to many...?', 'Living Things', 'Robots', 'Cars')

ON CONFLICT (id) DO UPDATE SET
  question_text = EXCLUDED.question_text,
  correct_option = EXCLUDED.correct_option,
  wrong_option_1 = EXCLUDED.wrong_option_1,
  wrong_option_2 = EXCLUDED.wrong_option_2;

COMMIT;
