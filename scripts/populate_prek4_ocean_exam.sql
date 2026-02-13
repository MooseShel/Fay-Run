-- ==========================================
-- PRE-K 4 (Grade -1) EXAM: OCEAN ANIMALS
-- Topic: Ocean Animals & Habitats
-- ==========================================

BEGIN;

-- 1. Create Challenge Record for the Exam
INSERT INTO challenges (id, topic, grade_level, difficulty_level, is_exam, exam_name, due_date) VALUES 
('exam_prek4_ocean', 'Ocean Animals', -1, 1, TRUE, 'Ocean Animals & Habitats', '2026-03-15 23:59:59+00')
ON CONFLICT (id) DO UPDATE SET 
  is_exam = TRUE,
  exam_name = EXCLUDED.exam_name,
  due_date = EXCLUDED.due_date;

-- 2. Ocean Questions (15)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) VALUES
-- Identification
('q_prek4_ocean_1', 'exam_prek4_ocean', 'What animal has 8 arms and lives in the ocean?', 'Octopus', 'Cat', 'Bird'),
('q_prek4_ocean_2', 'exam_prek4_ocean', 'Which ocean animal is very, very big?', 'Whale', 'Ant', 'Mouse'),
('q_prek4_ocean_3', 'exam_prek4_ocean', 'Does a fish float or sink in the ocean?', 'Float and Swim', 'Fly', 'Walk'),
('q_prek4_ocean_4', 'exam_prek4_ocean', 'What do fish use to swim through the water?', 'Fins', 'Wings', 'Legs'),
('q_prek4_ocean_5', 'exam_prek4_ocean', 'What animal has a hard shell and crawls on the shore?', 'Crab', 'Rabbit', 'Butterfly'),

-- Habitats & Concepts
('q_prek4_ocean_6', 'exam_prek4_ocean', 'What is the big blue water called?', 'Ocean or Sea', 'Forest', 'Park'),
('q_prek4_ocean_7', 'exam_prek4_ocean', 'Where do waves come to the land?', 'The Shore or Beach', 'The Kitchen', 'The School'),
('q_prek4_ocean_8', 'exam_prek4_ocean', 'What is a place where an animal lives called?', 'Habitat', 'House', 'Box'),
('q_prek4_ocean_9', 'exam_prek4_ocean', 'What colorful hard things grow in a reef?', 'Coral', 'Grass', 'Flowers'),
('q_prek4_ocean_10', 'exam_prek4_ocean', 'What goes up and down with the ocean water?', 'The Tide', 'The Sun', 'A Ball'),

-- Care & Conservation
('q_prek4_ocean_11', 'exam_prek4_ocean', 'Should we throw trash in the sea?', 'No, keep it clean', 'Yes', 'Only on Tuesdays'),
('q_prek4_ocean_12', 'exam_prek4_ocean', 'What can we do with a plastic bottle to help the ocean?', 'Recycle it', 'Throw it in the water', 'Hide it'),
('q_prek4_ocean_13', 'exam_prek4_ocean', 'Pollution makes the ocean water...?', 'Dirty', 'Clean', 'Sparkly'),

-- Simple Ecosystem
('q_prek4_ocean_14', 'exam_prek4_ocean', 'What do we call an animal that hunts others for food?', 'Predator', 'Friend', 'Helper'),
('q_prek4_ocean_15', 'exam_prek4_ocean', 'What do we call an animal that is being hunted?', 'Prey', 'Predator', 'Hunter')

ON CONFLICT (id) DO UPDATE SET
  question_text = EXCLUDED.question_text,
  correct_option = EXCLUDED.correct_option,
  wrong_option_1 = EXCLUDED.wrong_option_1,
  wrong_option_2 = EXCLUDED.wrong_option_2;

COMMIT;
