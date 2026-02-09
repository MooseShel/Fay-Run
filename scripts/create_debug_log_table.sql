-- Debug Log Table for Exception Tracking
-- Run this in Supabase SQL Editor

CREATE TABLE IF NOT EXISTS debug_log (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL,
  level TEXT NOT NULL DEFAULT 'error',  -- 'error', 'warning', 'info'
  message TEXT NOT NULL,
  stack_trace TEXT,
  device_info TEXT,  -- JSON with platform, OS version, app version
  context TEXT       -- Additional context (screen name, action, etc.)
);

-- Index for querying recent errors
CREATE INDEX IF NOT EXISTS idx_debug_log_created_at ON debug_log(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_debug_log_level ON debug_log(level);

-- Enable RLS but allow inserts from authenticated users
ALTER TABLE debug_log ENABLE ROW LEVEL SECURITY;

-- Policy: Any authenticated user can insert their own logs
CREATE POLICY "Users can insert their own logs" ON debug_log
  FOR INSERT TO authenticated
  WITH CHECK (true);

-- Policy: Users can only view their own logs (optional - for debugging)
CREATE POLICY "Users can view their own logs" ON debug_log
  FOR SELECT TO authenticated
  USING (auth.uid() = user_id);

-- Policy: Service role can do everything (for admin access)
CREATE POLICY "Service role full access" ON debug_log
  FOR ALL TO service_role
  USING (true)
  WITH CHECK (true);
