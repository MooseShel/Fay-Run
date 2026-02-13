-- ==========================================
-- DATABASE REDESIGN: SIMPLIFIED SYSTEM
-- Removing time-based constraints and focusing on Grade/Difficulty/Exam
-- ==========================================

BEGIN;

-- 1. Ensure new columns and defaults exist
ALTER TABLE public.challenges ADD COLUMN IF NOT EXISTS difficulty_level INTEGER DEFAULT 1;
ALTER TABLE public.challenges ADD COLUMN IF NOT EXISTS is_exam BOOLEAN DEFAULT FALSE;
ALTER TABLE public.challenges ADD COLUMN IF NOT EXISTS exam_name TEXT;
ALTER TABLE public.challenges ADD COLUMN IF NOT EXISTS due_date TIMESTAMPTZ;

-- 2. Migrate existing data
-- Map week_number to difficulty_level for all existing challenges if difficulty is not set
UPDATE public.challenges 
SET difficulty_level = week_number 
WHERE difficulty_level IS NULL OR difficulty_level = 1;

-- 3. Cleanup: Drop unneeded columns
-- We use a DO block to avoid errors if columns are already gone
DO $$ 
BEGIN 
    ALTER TABLE public.challenges DROP COLUMN IF EXISTS season; 
    ALTER TABLE public.challenges DROP COLUMN IF EXISTS week_number; 
    ALTER TABLE public.challenges DROP COLUMN IF EXISTS active_start_date; 
    ALTER TABLE public.challenges DROP COLUMN IF EXISTS active_end_date; 
EXCEPTION 
    WHEN OTHERS THEN NULL; 
END $$;

-- 4. Standardize Existing Data
-- All "Normal" challenges should have a topic if they don't
UPDATE public.challenges SET topic = 'General' WHERE topic IS NULL OR topic = '';

-- 5. Finalize Schema Constraints (Optional but recommended)
-- We keep ID as PK. topic, grade_level, is_exam are the primary filters.

COMMIT;
