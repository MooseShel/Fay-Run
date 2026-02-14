import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../providers/game_state.dart';

class StudentSetupScreen extends StatefulWidget {
  const StudentSetupScreen({super.key});

  @override
  State<StudentSetupScreen> createState() => _StudentSetupScreenState();
}

class _StudentSetupScreenState extends State<StudentSetupScreen> {
  final _nameController = TextEditingController();
  String _nickname = '';
  bool _isSaving = false;

  String _selectedGrade = '1st';
  final List<String> _grades = [
    'Pre-K (3yo)',
    'Pre-K (4yo)',
    'Kindergarten',
    '1st',
    '2nd',
    '3rd',
    '4th',
    '5th'
  ];

  final List<String> _adjectives = [
    "Swampy",
    "Turbo",
    "Muddy",
    "Gator",
    "Bayou",
  ];
  final List<String> _nouns = ["Scholar", "Rocket", "Wizard", "Legend"];

  void _generateNickname() {
    if (_nameController.text.isEmpty) return;

    final random = Random();
    final adj = _adjectives[random.nextInt(_adjectives.length)];
    final noun = _nouns[random.nextInt(_nouns.length)];

    setState(() {
      _nickname = "${_nameController.text} the $adj $noun";
    });
  }

  Future<void> _saveStudent({bool addAnother = false}) async {
    if (_nameController.text.isEmpty || _nickname.isEmpty) return;

    setState(() => _isSaving = true);
    try {
      // Register Student via GameState
      await context.read<GameState>().registerStudent(
            _nameController.text,
            _nickname,
            _selectedGrade,
          );

      if (!mounted) return;

      if (addAnother) {
        // Reset form for next student
        _nameController.clear();
        setState(() {
          _nickname = '';
          _selectedGrade = '1st';
          _isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Student added! Add another or finish.'),
          ),
        );
      } else {
        // Finish and go back to selection
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacementNamed(context, '/select_student');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving student: $e')));
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Student Setup')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.face, size: 100, color: FayColors.navy),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'What is your First Name?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGrade,
                decoration: const InputDecoration(
                  labelText: 'Grade Level',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                items: _grades.map((grade) {
                  return DropdownMenuItem(value: grade, child: Text(grade));
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedGrade = value);
                  }
                },
              ),
              const SizedBox(height: 20),
              if (_nickname.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: FayColors.gold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: FayColors.gold, width: 2),
                  ),
                  child: Text(
                    _nickname,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: FayColors.navy,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _generateNickname,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('Generate Bayou Nickname'),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (_nickname.isNotEmpty && !_isSaving)
                            ? () => _saveStudent(addAnother: true)
                            : null,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side:
                              const BorderSide(color: FayColors.navy, width: 2),
                        ),
                        child: const Text('Save & Add Another'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (_nickname.isNotEmpty && !_isSaving)
                            ? () => _saveStudent(addAnother: false)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: FayColors.navy,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Finish & Play'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
