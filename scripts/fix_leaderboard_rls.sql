-- Fix: Replace the global_leaderboard view with a SECURITY DEFINER function.
-- Regular views inherit the underlying table's RLS, so the old view only
-- returned the authenticated parent's own children.  A SECURITY DEFINER
-- function runs with the *owner's* privileges and bypasses RLS, exposing
-- the full leaderboard to any authenticated caller.

-- 1. Create the RPC function
CREATE OR REPLACE FUNCTION get_leaderboard(grade_filter TEXT DEFAULT NULL)
RETURNS TABLE (first_name TEXT, nickname TEXT, grade TEXT, high_score INT)
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT s.first_name, s.nickname, s.grade, s.high_score
  FROM students s
  WHERE s.high_score > 0
    AND (grade_filter IS NULL OR s.grade = grade_filter)
  ORDER BY s.high_score DESC
  LIMIT 10;
$$;

-- 2. Grant execute to authenticated users
GRANT EXECUTE ON FUNCTION get_leaderboard(TEXT) TO authenticated;
