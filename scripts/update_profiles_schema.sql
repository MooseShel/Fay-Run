-- 1. Add new columns for Parent Name
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS first_name text,
ADD COLUMN IF NOT EXISTS last_name text;

-- 2. Migrate existing data (Optional: Try to split 'nickname' or 'full_name' into first/last)
-- Assuming 'nickname' held the full name previously
UPDATE public.profiles
SET 
  first_name = split_part(nickname, ' ', 1),
  last_name = substring(nickname from position(' ' in nickname) + 1)
WHERE first_name IS NULL AND nickname IS NOT NULL AND position(' ' in nickname) > 0;

-- Handle cases with single names
UPDATE public.profiles
SET first_name = nickname, last_name = ''
WHERE first_name IS NULL AND nickname IS NOT NULL AND position(' ' in nickname) = 0;

-- 3. (Optional) Remove Student-specific columns from Parent Profile
-- Only run this if you are sure you want to delete this data!
-- The app no longer uses these for parents.
-- ALTER TABLE public.profiles DROP COLUMN IF EXISTS grade;
-- ALTER TABLE public.profiles DROP COLUMN IF EXISTS nickname;

-- 4. Verify 'students' table linkage (should already exist)
-- Ensure students link to profiles.id via parent_id
-- ALTER TABLE public.students 
-- ADD CONSTRAINT fk_students_parent 
-- FOREIGN KEY (parent_id) REFERENCES public.profiles (id) ON DELETE CASCADE;
