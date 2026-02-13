-- Batch 1: Grade -2 (Pre-K 3yo) and Grade -1 (Pre-K 4yo)
-- Adding 10 new questions per challenge (Total 200 questions)

-- ==========================================
-- GRADE -2: PRE-K (3 YEAR OLDS)
-- Topics: Math (1-4), Science (5-7), Social (8-10)
-- ==========================================

-- LVL 1 MATH: Identification (1)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_1_11', 'gen_neg2_1', 'Touch the circle!', '🔴', '🟦', '🔺', '⭐'),
('q_n2_1_12', 'gen_neg2_1', 'Which one is RED?', '🍎', '🍌', '🍇', '🥦'),
('q_n2_1_13', 'gen_neg2_1', 'How many ducks? (1)', '🦆', '🦆🦆', '🦆🦆🦆', '0'),
('q_n2_1_14', 'gen_neg2_1', 'Find the star!', '⭐', '☁️', '🌙', '☀️'),
('q_n2_1_15', 'gen_neg2_1', 'Which is BIG?', '🐘', '🐭', '🐜', '🐝'),
('q_n2_1_16', 'gen_neg2_1', 'Find the color BLUE.', '🫐', '🍓', '🍋', '🥬'),
('q_n2_1_17', 'gen_neg2_1', 'Find the number 1.', '1', '2', '3', '0'),
('q_n2_1_18', 'gen_neg2_1', 'Which one is a square?', '🟦', '🔴', '🔺', '💖'),
('q_n2_1_19', 'gen_neg2_1', 'Touch the happy face!', '😊', '😢', '😠', '😴'),
('q_n2_1_20', 'gen_neg2_1', 'Which one is YELLOW?', '🍌', '🍎', '🫐', '🍇');

-- LVL 2 MATH: Identification (2)
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_2_11', 'gen_neg2_2', 'Find the triangle!', '🔺', '🟦', '🔴', '🟠'),
('q_n2_2_12', 'gen_neg2_2', 'Which number is 2?', '2', '1', '3', '4'),
('q_n2_2_13', 'gen_neg2_2', 'Which one is SMALL?', '🐜', '🐘', '🏠', '🚌'),
('q_n2_2_14', 'gen_neg2_2', 'Find the color GREEN.', '🍏', '🍎', '🍇', '🍊'),
('q_n2_2_15', 'gen_neg2_2', 'How many fish? (2)', '🐟🐟', '🐟', '🐟🐟🐟', '0'),
('q_n2_2_16', 'gen_neg2_2', 'Touch the heart!', '💖', '⭐', '🌙', '☁️'),
('q_n2_2_17', 'gen_neg2_2', 'Find the number 3.', '3', '1', '2', '5'),
('q_n2_2_18', 'gen_neg2_2', 'Which one is ORANGE?', '🍊', '🍏', '🫐', '🍒'),
('q_n2_2_19', 'gen_neg2_2', 'Touch the sun!', '☀️', '🌙', '⭐', '🌧️'),
('q_n2_2_20', 'gen_neg2_2', 'Which animal is TALL?', '🦒', '🐢', '🐈', '🐀');

-- LVL 3 MATH: Sorting & Basics
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_3_11', 'gen_neg2_3', 'Find the fruit!', '🍎', '🚗', '🧸', '👟'),
('q_n2_3_12', 'gen_neg2_3', 'Which one is PINK?', '🌸', '🌲', '🌊', '☀️'),
('q_n2_3_13', 'gen_neg2_3', 'Find the number 4.', '4', '2', '3', '1'),
('q_n2_3_14', 'gen_neg2_3', 'Which one is a toy?', '🧸', '🥦', '🥄', '🛋️'),
('q_n2_3_15', 'gen_neg2_3', 'Touch the moon!', '🌙', '☀️', '☁️', '🌈'),
('q_n2_3_16', 'gen_neg2_3', 'How many cars? (3)', '🚗🚗🚗', '🚗', '🚗🚗', '0'),
('q_n2_3_17', 'gen_neg2_3', 'Which is for your feet?', '👟', '🎩', '🧤', '👓'),
('q_n2_3_18', 'gen_neg2_3', 'Find the color PURPLE.', '🍇', '🍋', '🍎', '🥦'),
('q_n2_3_19', 'gen_neg2_3', 'Which one is LONGEST?', '🐍', '🐜', '🐞', '🐌'),
('q_n2_3_20', 'gen_neg2_3', 'Find the number 5.', '5', '1', '2', '3');

-- LVL 4 MATH: Shapes & Sizes
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_4_11', 'gen_neg2_4', 'Find the diamond!', '💠', '🔴', '🟦', '🔺'),
('q_n2_4_12', 'gen_neg2_4', 'Which one is ROUND?', '⚽', '📦', '🪜', '📏'),
('q_n2_4_13', 'gen_neg2_4', 'Find the number 0.', '0', '1', '2', '3'),
('q_n2_4_14', 'gen_neg2_4', 'Which is for eating?', '🍎', '⚽', '🚗', '👟'),
('q_n2_4_15', 'gen_neg2_4', 'Find the color BROWN.', '🐻', '🦜', '🦢', '🦩'),
('q_n2_4_16', 'gen_neg2_4', 'How many trees? (1)', '🌲', '🌲🌲', '🌲🌲🌲', '0'),
('q_n2_4_17', 'gen_neg2_4', 'Which is WIDE?', '🛣️', '📏', '🧵', '🖍️'),
('q_n2_4_18', 'gen_neg2_4', 'Touch the rainbow!', '🌈', '🌧️', '🌪️', '❄️'),
('q_n2_4_19', 'gen_neg2_4', 'Find the number 6.', '6', '1', '2', '3'),
('q_n2_4_20', 'gen_neg2_4', 'Which one is a ball?', '🏀', '🧊', '📱', '📖');

-- LVL 5 SCIENCE: Animals
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_5_11', 'gen_neg2_5', 'Who says Meow?', '🐱', '🐶', '🐮', '🐷'),
('q_n2_5_12', 'gen_neg2_5', 'Who lives in water?', '🐟', '🦁', '🦅', '🐒'),
('q_n2_5_13', 'gen_neg2_5', 'Touch the bird!', '🐦', '🐈', '🐕', '🐇'),
('q_n2_5_14', 'gen_neg2_5', 'Who says Moo?', '🐮', '🐑', '🐔', '🐴'),
('q_n2_5_15', 'gen_neg2_5', 'Who has a trunk?', '🐘', '🦒', '🦓', '🐅'),
('q_n2_5_16', 'gen_neg2_5', 'Who can fly?', '🦋', '🐘', '🐢', '🐊'),
('q_n2_5_17', 'gen_neg2_5', 'Touch the monkey!', '🐒', '🦢', '🦘', '🐪'),
('q_n2_5_18', 'gen_neg2_5', 'Who has wool?', '🐑', '🐍', '🐸', '🐜'),
('q_n2_5_19', 'gen_neg2_5', 'Who says Woof?', '🐶', '🐱', '🐭', '🐨'),
('q_n2_5_20', 'gen_neg2_5', 'Who has long ears?', '🐇', '🐹', '🐿️', '🦔');

-- LVL 6 SCIENCE: Plants & Nature
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_6_11', 'gen_neg2_6', 'Touch the flower!', '🌻', '🪨', '🚗', '🏠'),
('q_n2_6_12', 'gen_neg2_6', 'What is COLD?', '❄️', '🔥', '☀️', '🌋'),
('q_n2_6_13', 'gen_neg2_6', 'What falls from the sky?', '🌧️', '🍎', '👟', '🧸'),
('q_n2_6_14', 'gen_neg2_6', 'Touch the leaf!', '🍃', '🧱', '🔑', '🧢'),
('q_n2_6_15', 'gen_neg2_6', 'What is HOT?', '🔥', '🍦', '🧊', '⛄'),
('q_n2_6_16', 'gen_neg2_6', 'Find the tree!', '🌳', '🚲', '🪁', '🏐'),
('q_n2_6_17', 'gen_neg2_6', 'Where do we see stars?', '🌃', '🍳', '🛁', '🚪'),
('q_n2_6_18', 'gen_neg2_6', 'Which grows from soil?', '🌱', '📎', '🪙', '🔋'),
('q_n2_6_19', 'gen_neg2_6', 'Touch the grass!', '🌱', '🏜️', '🏢', '🛤️'),
('q_n2_6_20', 'gen_neg2_6', 'What makes us wet?', '💧', '💨', '☀️', '🪵');

-- LVL 7 SCIENCE: Body & Health
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_7_11', 'gen_neg2_7', 'Touch your nose!', '👃', '👂', '👀', '👄'),
('q_n2_7_12', 'gen_neg2_7', 'What do we use to see?', '👀', '🦶', '🖐️', '👂'),
('q_n2_7_13', 'gen_neg2_7', 'Touch your hand!', '🖐️', '🦵', '💪', '👅'),
('q_n2_7_14', 'gen_neg2_7', 'What do we use to hear?', '👂', '👃', '👄', '🤚'),
('q_n2_7_15', 'gen_neg2_7', 'Touch your smile!', '👄', '👣', '🤚', '👃'),
('q_n2_7_16', 'gen_neg2_7', 'What do we use to walk?', '🦶', '👂', '👃', '🖐️'),
('q_n2_7_17', 'gen_neg2_7', 'Touch your ears!', '👂', '👃', '👅', '🖐️'),
('q_n2_7_18', 'gen_neg2_7', 'What do we brush?', '🦷', '👂', '👃', '🦶'),
('q_n2_7_19', 'gen_neg2_7', 'Touch your hair!', '💇', '🦶', '🤚', '👅'),
('q_n2_7_20', 'gen_neg2_7', 'What do we use to clap?', '🖐️', '👂', '👃', '🦶');

-- LVL 8 SOCIAL: Family & Home
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_8_11', 'gen_neg2_8', 'Where do we sleep?', '🛏️', '🥣', '🌳', '🚗'),
('q_n2_8_12', 'gen_neg2_8', 'Touch the house!', '🏠', '🧁', '🎈', '🖍️'),
('q_n2_8_13', 'gen_neg2_8', 'Who takes care of us?', '👩‍🍼', '🦖', '🐝', '🐜'),
('q_n2_8_14', 'gen_neg2_8', 'Where do we sit?', '🪑', '🚿', '🚪', '🪜'),
('q_n2_8_15', 'gen_neg2_8', 'Touch the baby!', '👶', '👴', '🏢', '🚲'),
('q_n2_8_16', 'gen_neg2_8', 'Where do we cook?', '🍳', '🛁', '🛏️', '🛋️'),
('q_n2_8_17', 'gen_neg2_8', 'Touch the door!', '🚪', '☁️', '🌳', '👟'),
('q_n2_8_18', 'gen_neg2_8', 'Where do we play?', '🎠', '📖', '🧼', '🗝️'),
('q_n2_8_19', 'gen_neg2_8', 'Touch the window!', '🪟', '🛏️', '🛋️', '🚪'),
('q_n2_8_20', 'gen_neg2_8', 'What is for drinking?', '🥛', '🧸', '👟', '🖍️');

-- LVL 9 SOCIAL: Community Helpers
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_9_11', 'gen_neg2_9', 'Who helps when we are sick?', '🧑‍⚕️', '🧑‍🚒', '🧑‍🚀', '🧑‍🍳'),
('q_n2_9_12', 'gen_neg2_9', 'Who puts out fires?', '🧑‍🚒', '🧑‍⚕️', '🧑‍🌾', '🧑‍🏫'),
('q_n2_9_13', 'gen_neg2_9', 'Who teaches us?', '🧑‍🏫', '🧑‍🚒', '🧑‍🔬', '🧑‍🎨'),
('q_n2_9_14', 'gen_neg2_9', 'Who flies a plane?', '🧑‍✈️', '🧑‍🚒', '🧑‍💼', '🧑‍🌾'),
('q_n2_9_15', 'gen_neg2_9', 'Who brings the mail?', '📮', '🚒', '🚀', '🚜'),
('q_n2_9_16', 'gen_neg2_9', 'Who grows food?', '🧑‍🌾', '🧑‍⚕️', '🧑‍🏫', '🧑‍🚀'),
('q_n2_9_17', 'gen_neg2_9', 'Who cooks meals?', '🧑‍🍳', '🧑‍🚒', '🧑‍🏫', '🧑‍✈️'),
('q_n2_9_18', 'gen_neg2_9', 'Who keeps us safe?', '👮', '🤡', '🧚', '👾'),
('q_n2_9_19', 'gen_neg2_9', 'Who helps our teeth?', '🦷', '🦶', '👂', '👃'),
('q_n2_9_20', 'gen_neg2_9', 'Who drives a bus?', '🚌', '🛶', '🛸', '🛷');

-- LVL 10 SOCIAL: School & Friends
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n2_10_11', 'gen_neg2_10', 'What do we use to color?', '🖍️', '🥣', '🛏️', '🛁'),
('q_n2_10_12', 'gen_neg2_10', 'Touch the book!', '📖', '⚽', '🚗', '🧸'),
('q_n2_10_13', 'gen_neg2_10', 'What do we do with friends?', '🤝', '😠', '😢', '😤'),
('q_n2_10_14', 'gen_neg2_10', 'Where do we go to learn?', '🏫', '🏖️', '⛰️', '🏕️'),
('q_n2_10_15', 'gen_neg2_10', 'Touch the backpack!', '🎒', '👞', '👒', '🧤'),
('q_n2_10_16', 'gen_neg2_10', 'What do we do at recess?', '🏃', '😴', '🛀', '🍳'),
('q_n2_10_17', 'gen_neg2_10', 'Touch the pencil!', '✏️', '🥣', '🛁', '🛏️'),
('q_n2_10_18', 'gen_neg2_10', 'What do we use to glue?', '🧴', '🖍️', '📖', '🎒'),
('q_n2_10_19', 'gen_neg2_10', 'Touch the scissors!', '✂️', '🧸', '🚗', '⚽'),
('q_n2_10_20', 'gen_neg2_10', 'How do we listen?', '🤫', '📢', '😝', '😴');

-- ==========================================
-- GRADE -1: PRE-K (4 YEAR OLDS)
-- Topics: Science (1-10) - Based on your previous data, Grade -1 used Science for all levels
-- ==========================================

-- LVL 1 SCIENCE: Living vs Non-living
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_1_11', 'gen_neg1_1', 'Which one grows?', '🌳', '🪨', '🚗', '🧱'),
('q_n1_1_12', 'gen_neg1_1', 'Which one needs water?', '🐶', '🧸', '🚲', '🛹'),
('q_n1_1_13', 'gen_neg1_1', 'Which one can move itself?', '🐈', '🪑', '👟', '🕶️'),
('q_n1_1_14', 'gen_neg1_1', 'Which one is ALIVE?', '🌻', '🏐', '🎷', '🎻'),
('q_n1_1_15', 'gen_neg1_1', 'Which one breathes air?', '🐦', '🧴', '🗝️', '📎'),
('q_n1_1_16', 'gen_neg1_1', 'Which one needs food?', '🐘', '🪁', '🖍️', '📱'),
('q_n1_1_17', 'gen_neg1_1', 'Which one is NOT alive?', '🧸', '🦋', '🐟', '🌳'),
('q_n1_1_18', 'gen_neg1_1', 'Which one can have babies?', '🐰', '🚗', '🏠', '📺'),
('q_n1_1_19', 'gen_neg1_1', 'Which one stays the same?', '🪨', '👶', '🌱', '🐣'),
('q_n1_1_20', 'gen_neg1_1', 'Which one needs sunlight?', '🌱', '🧥', '👞', '👒');

-- LVL 2 SCIENCE: Animal Habitats
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_2_11', 'gen_neg1_2', 'Who lives in the OCEAN?', '🐋', '🦁', '🐫', '🦉'),
('q_n1_2_12', 'gen_neg1_2', 'Who lives in a TREE?', '🐿️', '🐢', '🦀', '🐪'),
('q_n1_2_13', 'gen_neg1_2', 'Who lives in the JUNGLE?', '🐒', '🐧', '🐎', '🐄'),
('q_n1_2_14', 'gen_neg1_2', 'Who lives in the DESERT?', '🐫', '🐻', '🐑', '🐧'),
('q_n1_2_15', 'gen_neg1_2', 'Who lives on a FARM?', '🐄', '🦖', '🦈', '🦒'),
('q_n1_2_16', 'gen_neg1_2', 'Where does a BEE live?', '🐝', '🐜', '🕷️', '🦋'),
('q_n1_2_17', 'gen_neg1_2', 'Who lives in the ICE?', '🐧', '🐅', '🐘', '🐒'),
('q_n1_2_18', 'gen_neg1_2', 'Who lives in a BURROW?', '🐰', '🦅', '🦅', '🦅'),
('q_n1_2_19', 'gen_neg1_2', 'Who lives in a WEB?', '🕷️', '🐤', '🦋', '🐜'),
('q_n1_2_20', 'gen_neg1_2', 'Where does an EAGLE live?', '🦅', '🐙', '🐊', '🐄');

-- LVL 3 SCIENCE: Animal Traits
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_3_11', 'gen_neg1_3', 'Who has feathers?', '🦜', '🐻', '🐍', '🐸'),
('q_n1_3_12', 'gen_neg1_3', 'Who has scales?', '🐍', '🐩', '🐇', '🐑'),
('q_n1_3_13', 'gen_neg1_3', 'Who has fur?', '🐻', '🦅', '🐊', '🐞'),
('q_n1_3_14', 'gen_neg1_3', 'Who laid this egg? 🥚', '🐔', '🐈', '🐕', '🐄'),
('q_n1_3_15', 'gen_neg1_3', 'Who has a long neck?', '🦒', '🐖', '🐹', '🐀'),
('q_n1_3_16', 'gen_neg1_3', 'Who jumps high?', '🦘', '🐌', '🐢', '🐘'),
('q_n1_3_17', 'gen_neg1_3', 'Who has a shell?', '🐢', '🦢', '🐆', '🐒'),
('q_n1_3_18', 'gen_neg1_3', 'Who has 8 legs?', '🕷️', '🐱', '🦋', '🐶'),
('q_n1_3_19', 'gen_neg1_3', 'Who has whiskers?', '🐱', '🐦', '🐟', '🦋'),
('q_n1_3_20', 'gen_neg1_3', 'Who has stripes?', '🦓', '🦒', '🐘', '🦏');

-- LVL 4 SCIENCE: Life Cycles
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_4_11', 'gen_neg1_4', 'What does a caterpillar become?', '🦋', '🐜', '🕷️', '🐝'),
('q_n1_4_12', 'gen_neg1_4', 'What hatches from an egg?', '🐣', '🐶', '🐱', '🐮'),
('q_n1_4_13', 'gen_neg1_4', 'What does a seed grow into?', '🌱', '🪨', '🚲', '🏠'),
('q_n1_4_14', 'gen_neg1_4', 'What was a frog before?', '🐸', '🐱', '🐶', '🐷'),
('q_n1_4_15', 'gen_neg1_4', 'What was a big tree before?', '🌱', '☁️', '🌧️', '☀️'),
('q_n1_4_16', 'gen_neg1_4', 'What was a butterfly before?', '🐛', '🕷️', '🐜', '🪲'),
('q_n1_4_17', 'gen_neg1_4', 'What does a puppy grow into?', '🐕', '🐈', '🐖', '🐑'),
('q_n1_4_18', 'gen_neg1_4', 'What does a kitten grow into?', '🐈', '🐕', '🐄', '🐎'),
('q_n1_4_19', 'gen_neg1_4', 'What does a bulb grow into?', '🌷', '🍎', '🥕', '🥔'),
('q_n1_4_20', 'gen_neg1_4', 'What was a chicken before?', '🥚', '🌽', '🪱', '🍞');

-- LVL 5 SCIENCE: Seasons
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_5_11', 'gen_neg1_5', 'When do leaves fall?', '🍂', '🌸', '❄️', '☀️'),
('q_n1_5_12', 'gen_neg1_5', 'When is it snowy?', '❄️', '🔥', '🌊', '🌪️'),
('q_n1_5_13', 'gen_neg1_5', 'When do flowers bloom?', '🌸', '🍂', '❄️', '💨'),
('q_n1_5_14', 'gen_neg1_5', 'When is it very hot?', '☀️', '🧥', '🧤', '🧣'),
('q_n1_5_15', 'gen_neg1_5', 'When do we wear a coat?', '❄️', '🩳', '👙', '🕶️'),
('q_n1_5_16', 'gen_neg1_5', 'When do we wear a swimsuit?', '⛱️', '⛸️', '⛷️', '🏂'),
('q_n1_5_17', 'gen_neg1_5', 'When do animals hibernate?', '❄️', '🌱', '☀️', '🍃'),
('q_n1_5_18', 'gen_neg1_5', 'When are the days longest?', '☀️', '🌧️', '❄️', '🍂'),
('q_n1_5_19', 'gen_neg1_5', 'When do we use an umbrella?', '🌧️', '🔥', '🏂', '🛹'),
('q_n1_5_20', 'gen_neg1_5', 'When do trees have green leaves?', '🌳', '🍂', '❄️', '⛄');

-- LVL 6 SCIENCE: Weather
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_6_11', 'gen_neg1_6', 'What makes a rainbow?', '☀️🌧️', '👟', '🧸', '🚗'),
('q_n1_6_12', 'gen_neg1_6', 'What makes the trees move?', '💨', '☀️', '🌕', '✨'),
('q_n1_6_13', 'gen_neg1_6', 'What comes after lightning?', '⚡🔊', '🍦', '🎈', '🖍️'),
('q_n1_6_14', 'gen_neg1_6', 'What blocks the sun?', '☁️', '⭐', '🍎', '📖'),
('q_n1_6_15', 'gen_neg1_6', 'What is cold and white?', '❄️', '🔥', '🧱', '🛣️'),
('q_n1_6_16', 'gen_neg1_6', 'What is the big ball of fire?', '☀️', '🌙', '🌏', '🏐'),
('q_n1_6_17', 'gen_neg1_6', 'What do we see at night?', '🌕', '☀️', '🌈', '🌪️'),
('q_n1_6_18', 'gen_neg1_6', 'What sound does wind make?', '🌬️', '🔔', '🎹', '🎸'),
('q_n1_6_19', 'gen_neg1_6', 'What is a scary wind?', '🌪️', '☁️', '🌈', '❄️'),
('q_n1_6_20', 'gen_neg1_6', 'What makes it hard to see?', '🌫️', '☀️', '🌈', '✨');

-- LVL 7 SCIENCE: Five Senses
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_7_11', 'gen_neg1_7', 'What do we use to TASTE?', '👅', '👂', '👀', '👃'),
('q_n1_7_12', 'gen_neg1_7', 'What do we use to SMELL?', '👃', '🦶', '🖐️', '👂'),
('q_n1_7_13', 'gen_neg1_7', 'What do we use to TOUCH?', '🖐️', '👅', '👂', '👃'),
('q_n1_7_14', 'gen_neg1_7', 'What is LOUD?', '📢', '🤫', '☁️', '🌙'),
('q_n1_7_15', 'gen_neg1_7', 'What is SWEET?', '🍭', '🍋', '🥨', '🥦'),
('q_n1_7_16', 'gen_neg1_7', 'What feels SOFT?', '🧸', '🪨', '🧱', '🔑'),
('q_n1_7_17', 'gen_neg1_7', 'What smells NICE?', '🌹', '🗑️', '🧦', '👟'),
('q_n1_7_18', 'gen_neg1_7', 'What is SOUR?', '🍋', '🍯', '🍫', '🍞'),
('q_n1_7_19', 'gen_neg1_7', 'What feels ROUGH?', '🪵', '🧊', '🧼', '🥛'),
('q_n1_7_20', 'gen_neg1_7', 'What is SHINY?', '💎', '💨', '🌧️', '🌫️');

-- LVL 8 SCIENCE: Outer Space
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_8_11', 'gen_neg1_8', 'What is the big yellow ball?', '☀️', '🌕', '🌏', '🪐'),
('q_n1_8_12', 'gen_neg1_8', 'What is the white ball at night?', '🌕', '☀️', '⭐', '🌈'),
('q_n1_8_13', 'gen_neg1_8', 'Who travels to space?', '🧑‍🚀', '🧑‍🍳', '🧑‍🌾', '🧑‍🚒'),
('q_n1_8_14', 'gen_neg1_8', 'What do we ride to the moon?', '🚀', '🚲', '🛹', '🛶'),
('q_n1_8_15', 'gen_neg1_8', 'Where do we live?', '🌏', '☀️', '🌕', '✨'),
('q_n1_8_16', 'gen_neg1_8', 'What twinkles at night?', '⭐', '🍎', '🧸', '🖍️'),
('q_n1_8_17', 'gen_neg1_8', 'What is the planet with rings?', '🪐', '☀️', '🌕', '🌏'),
('q_n1_8_18', 'gen_neg1_8', 'What is the red planet?', '🔴', '🔵', '🟢', '🟡'),
('q_n1_8_19', 'gen_neg1_8', 'What pulls us down?', '🌍', '🎈', '☁️', '💨'),
('q_n1_8_20', 'gen_neg1_8', 'Is there air in space?', '❌', '✅', '💨', '🌫️');

-- LVL 9 SCIENCE: Materials
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_9_11', 'gen_neg1_9', 'Which is made of WOOD?', '🪑', '🚲', '🪞', '🔑'),
('q_n1_9_12', 'gen_neg1_9', 'Which is made of METAL?', '🥄', '🖍️', '🧸', '🍎'),
('q_n1_9_13', 'gen_neg1_9', 'Which is made of PAPER?', '📖', '👟', '🥛', '🚲'),
('q_n1_9_14', 'gen_neg1_9', 'Which is made of GLASS?', '🪟', '🛏️', '🛋️', '🚪'),
('q_n1_9_15', 'gen_neg1_9', 'Which is made of FABRIC?', '👕', '🚲', '🪨', '🧱'),
('q_n1_9_16', 'gen_neg1_9', 'Which is made of PLASTIC?', '🥤', '🪵', '💎', '🌪️'),
('q_n1_9_17', 'gen_neg1_9', 'Which one is HARD?', '🪨', '☁️', '🍦', '🧼'),
('q_n1_9_18', 'gen_neg1_9', 'Which one is SOFT?', '☁️', '🧱', '🔑', '🪙'),
('q_n1_9_19', 'gen_neg1_9', 'Which one STRETCHES?', '🧣', '📏', '🪵', '🪨'),
('q_n1_9_20', 'gen_neg1_9', 'Which one BREAKS?', '🥚', '⚽', '🚗', '🧸');

-- LVL 10 SCIENCE: Magnets & Forces
INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2, wrong_option_3) VALUES
('q_n1_10_11', 'gen_neg1_10', 'What pulls metal?', '🧲', '🍎', '🧸', '🖍️'),
('q_n1_10_12', 'gen_neg1_10', 'Which one is a PUSH?', '🚪👋', '🛋️', '🛏️', '🛁'),
('q_n1_10_13', 'gen_neg1_10', 'Which one is a PULL?', '🚪🤝', '🌳', '🏠', '🏢'),
('q_n1_10_14', 'gen_neg1_10', 'What makes it roll?', '⚽', '📦', '🪜', '📏'),
('q_n1_10_15', 'gen_neg1_10', 'What makes it slide?', '🛹', '🌳', '🏠', '🏢'),
('q_n1_10_16', 'gen_neg1_10', 'What makes it sink?', '🪨', '🦢', '🎈', '☁️'),
('q_n1_10_17', 'gen_neg1_10', 'What makes it float?', '🪵', '🪨', '⚓', '🪙'),
('q_n1_10_18', 'gen_neg1_10', 'Which force brings it down?', '🌍', '💨', '☀️', '🌕'),
('q_n1_10_19', 'gen_neg1_10', 'Which is a FAST animal?', '🐆', '🐢', '🐌', '🐞'),
('q_n1_10_20', 'gen_neg1_10', 'Which is a SLOW animal?', '🐢', '🐆', '🦅', '🐎');
