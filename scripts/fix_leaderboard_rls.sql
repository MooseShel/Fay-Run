-- Fix leaderboard visibility: allow all authenticated users to read
-- student rows with a high_score, so the global_leaderboard view works.
--
-- PostgreSQL RLS policies are OR-based: a row is visible if ANY policy
-- matches.  The existing "Users can view own students" policy lets
-- parents see their own kids.  This new policy additionally lets every
-- authenticated user see any student row that has a score > 0, which
-- is exactly what the leaderboard needs.

-- Step 1 ----------------------------------------------------------------
-- Add a public-read policy for leaderboard rows
CREATE POLICY "Authenticated can read leaderboard rows"
  ON students
  FOR SELECT
  TO authenticated
  USING (high_score > 0);

-- Step 2 ----------------------------------------------------------------
-- Reload PostgREST schema cache so the API picks up changes immediately
NOTIFY pgrst, 'reload schema';
