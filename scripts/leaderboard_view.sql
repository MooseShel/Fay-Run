-- Create a secure view for the global leaderboard
-- Views execute with the permissions of the creator (bypassing the underlying table's RLS)
CREATE OR REPLACE VIEW global_leaderboard AS
SELECT 
    id, 
    first_name, 
    nickname, 
    grade, 
    high_score
FROM students
WHERE high_score > 0;

-- Grant access to the anon and authenticated roles so the Flutter app can query it
GRANT SELECT ON global_leaderboard TO anon, authenticated;
