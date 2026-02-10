-- Enable RLS on all tables
ALTER TABLE challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE students ENABLE ROW LEVEL SECURITY;
ALTER TABLE student_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- CHALLENGES & QUESTIONS (Public Read, Admin Write)
-- Allow everyone (anon and authenticated) to READ challenges and questions
CREATE POLICY "Public Read Challenges" ON challenges FOR SELECT USING (true);
CREATE POLICY "Public Read Questions" ON questions FOR SELECT USING (true);

-- Only allow service_role (dashboard/scripts) to INSERT/UPDATE/DELETE (Implicitly denied for others by default, but good to be explicit or just leave default deny)
-- No policy needed for write if we want to deny everyone except service_role.

-- PROFILES (Parent Data)
-- Users can insert their own profile
CREATE POLICY "Users can insert own profile" ON profiles FOR INSERT WITH CHECK (auth.uid() = id);
-- Users can read their own profile
CREATE POLICY "Users can read own profile" ON profiles FOR SELECT USING (auth.uid() = id);
-- Users can update their own profile
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- STUDENTS (Child Data linked to Parent)
-- 'students' table uses 'parent_id' to link to auth.users.id
CREATE POLICY "Users can view own students" ON students FOR SELECT USING (auth.uid() = parent_id);
CREATE POLICY "Users can insert own students" ON students FOR INSERT WITH CHECK (auth.uid() = parent_id);
CREATE POLICY "Users can update own students" ON students FOR UPDATE USING (auth.uid() = parent_id);
CREATE POLICY "Users can delete own students" ON students FOR DELETE USING (auth.uid() = parent_id);

-- STUDENT_PROGRESS (Scores/Unlocks)
-- Linked to 'students' via 'student_id'. Students are linked to 'parent_id' (auth.uid()).
-- We must check that the student belongs to the authenticated user.
CREATE POLICY "Users can view own student progress" ON student_progress FOR SELECT USING (
  EXISTS (SELECT 1 FROM students WHERE students.id = student_progress.student_id AND students.parent_id = auth.uid())
);

CREATE POLICY "Users can insert own student progress" ON student_progress FOR INSERT WITH CHECK (
  EXISTS (SELECT 1 FROM students WHERE students.id = student_progress.student_id AND students.parent_id = auth.uid())
);

CREATE POLICY "Users can update own student progress" ON student_progress FOR UPDATE USING (
  EXISTS (SELECT 1 FROM students WHERE students.id = student_progress.student_id AND students.parent_id = auth.uid())
);
