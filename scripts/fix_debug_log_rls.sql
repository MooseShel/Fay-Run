-- Allow anonymous users to log errors
-- Run this in Supabase SQL Editor
CREATE POLICY "Allow anon to insert logs" ON debug_log
  FOR INSERT TO anon
  WITH CHECK (true);
procee