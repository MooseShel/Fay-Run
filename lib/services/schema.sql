-- Fay Gator Run - Educational Content Schema

-- Table: challenges
-- Represents a weekly or seasonal set of questions specific to a grade/topic.
CREATE TABLE challenges (
    id TEXT PRIMARY KEY,
    topic TEXT NOT NULL,          -- e.g., "Geometry", "Fractions", "Louisiana History"
    season TEXT NOT NULL,         -- e.g., "Fall 2023", "Spring 2024"
    week_number INTEGER NOT NULL, -- e.g., 1, 2, ... 52
    difficulty_level INTEGER DEFAULT 1, -- 1-5, matching game levels?
    active_start_date DATETIME,   -- When this challenge becomes available
    active_end_date DATETIME      -- When it expires
);

-- Table: questions
-- Individual questions linked to a challenge.
CREATE TABLE questions (
    id TEXT PRIMARY KEY,
    challenge_id TEXT NOT NULL,
    question_text TEXT NOT NULL,
    correct_option TEXT NOT NULL,
    wrong_option_1 TEXT NOT NULL,
    wrong_option_2 TEXT NOT NULL,
    wrong_option_3 TEXT NOT NULL, -- Optional, can be empty/null if only 3 choices
    FOREIGN KEY (challenge_id) REFERENCES challenges(id) ON DELETE CASCADE
);

-- Table: student_progress
-- Tracks which challenges a student has completed.
CREATE TABLE student_progress (
    student_id TEXT NOT NULL,
    challenge_id TEXT NOT NULL,
    completed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    score INTEGER,
    PRIMARY KEY (student_id, challenge_id),
    FOREIGN KEY (challenge_id) REFERENCES challenges(id)
);

-- Sample Data Insertion Script (Template)
-- INSERT INTO challenges (id, topic, season, week_number) VALUES ('c_001', 'Bayou Ecology', 'Spring 2025', 1);
-- INSERT INTO questions (id, challenge_id, question_text, correct_option, wrong_option_1, wrong_option_2) 
-- VALUES ('q_001', 'c_001', 'What is the primary home of a gator?', 'Swamp', 'Desert', 'Mountain');
