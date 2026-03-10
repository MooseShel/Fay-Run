-- Backfill missing profiles for auth users who have students but no profile.
--
-- Root cause: the handle_new_user trigger was added after some users had
-- already signed up, so their auth.users entry exists (and students
-- reference it via parent_id) but no profiles row was ever created.
--
-- This script pulls first_name / last_name from auth.users.raw_user_meta_data
-- and creates the missing profile rows.  Nothing is deleted or overwritten.

-- 1. Backfill missing profiles from auth metadata
INSERT INTO public.profiles (id, first_name, last_name, updated_at)
SELECT
    au.id,
    au.raw_user_meta_data->>'first_name',
    au.raw_user_meta_data->>'last_name',
    now()
FROM auth.users au
WHERE NOT EXISTS (
    SELECT 1 FROM public.profiles p WHERE p.id = au.id
)
  AND EXISTS (
    SELECT 1 FROM public.students s WHERE s.parent_id = au.id
);

-- 2. Verify: This should return 0 rows after the backfill
SELECT s.parent_id, count(*) AS orphaned_students
FROM public.students s
LEFT JOIN public.profiles p ON p.id = s.parent_id
WHERE p.id IS NULL
GROUP BY s.parent_id;

-- 3. Ensure the auto-creation trigger exists for future sign-ups
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, first_name, last_name, updated_at)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'first_name',
    NEW.raw_user_meta_data->>'last_name',
    now()
  )
  ON CONFLICT (id) DO NOTHING;   -- prevent duplicates if trigger fires twice
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();
