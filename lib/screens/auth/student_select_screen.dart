import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../providers/game_state.dart';
import '../dashboard/leaderboard_screen.dart';
import '../../services/supabase_service.dart';

class StudentSelectScreen extends StatefulWidget {
  const StudentSelectScreen({super.key});

  @override
  State<StudentSelectScreen> createState() => _StudentSelectScreenState();
}

class _StudentSelectScreenState extends State<StudentSelectScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh students list on entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameState>().loadStudents();
    });
  }

  void _selectStudent(Map<String, dynamic> student) {
    context.read<GameState>().selectStudent(student);
    Navigator.pushReplacementNamed(context, '/menu');
  }

  Future<void> _addNewStudent() async {
    await Navigator.pushNamed(context, '/setup');
    // Refresh list on return (in case of pop)
    if (mounted) {
      context.read<GameState>().loadStudents();
    }
  }

  void _viewClassLeaderboards() {
    final students = context.read<GameState>().students;
    if (students.isEmpty) return;

    // Extract unique grades
    final grades = students
        .map((s) => s['grade'] as String?)
        .where((g) => g != null)
        .toSet()
        .toList();

    if (grades.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No grades found for students.')),
      );
      return;
    }

    if (grades.length == 1) {
      _openLeaderboard(grades.first!);
    } else {
      _showGradeSelectionDialog(grades.cast<String>());
    }
  }

  void _showGradeSelectionDialog(List<String> grades) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: FayColors.navy,
        title: const Text(
          'Select Grade',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: grades.map((grade) {
            return ListTile(
              title: Text(grade, style: const TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _openLeaderboard(grade);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _openLeaderboard(String grade) {
    context.read<GameState>().loadLeaderboard(grade: grade);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaderboardScreen(
          leaderboard: context.watch<GameState>().leaderboard,
          grade: grade,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final students = context.watch<GameState>().students;

    return Scaffold(
      backgroundColor: FayColors.navy,
      appBar: AppBar(
        title: const Text('Who is Playing?'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Don't go back to login easily?
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            tooltip: 'Class Leaderboards',
            onPressed: _viewClassLeaderboards,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await SupabaseService().signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Select Your Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: context.watch<GameState>().isLoading
                  ? Center(
                      child: const CircularProgressIndicator(
                        color: FayColors.gold,
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: students.length + 1, // +1 for "Add New"
                      itemBuilder: (context, index) {
                        if (index == students.length) {
                          // Add New Button
                          return _buildAddStudentCard();
                        }
                        final student = students[index];
                        return _buildStudentCard(student);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCard(Map<String, dynamic> student) {
    return GestureDetector(
      onTap: () => _selectStudent(student),
      child: Card(
        color: FayColors.gold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: FayColors.navy,
                child: Icon(Icons.face, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                student['first_name'] ?? 'Student',
                style: const TextStyle(
                  color: FayColors.navy,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                student['nickname'] ?? '',
                style: const TextStyle(
                  color: FayColors.navy,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: FayColors.navy.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  student['grade'] ?? 'Grade ?',
                  style: const TextStyle(
                    color: FayColors.navy,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddStudentCard() {
    return GestureDetector(
      onTap: _addNewStudent,
      child: Card(
        color: Colors.white.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white54, width: 2),
        ),
        elevation: 0,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_circle_outline, size: 50, color: Colors.white70),
              SizedBox(height: 12),
              Text(
                'Add Student',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
