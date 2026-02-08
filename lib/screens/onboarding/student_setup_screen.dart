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

  void _start() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name first!')),
      );
      return;
    }

    if (_nickname.isEmpty) {
      _generateNickname();
    }

    // Save to GameState
    context.read<GameState>().setStudentIdentity(
      _nameController.text,
      _nickname,
    );

    Navigator.pushReplacementNamed(context, '/menu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Student Setup')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
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
            if (_nickname.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: FayColors.gold.withOpacity(0.2),
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
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _start,
                style: ElevatedButton.styleFrom(
                  backgroundColor: FayColors.navy,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Enter the School'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
