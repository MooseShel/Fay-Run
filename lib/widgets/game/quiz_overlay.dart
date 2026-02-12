import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/challenge.dart';

class QuizOverlay extends StatefulWidget {
  final Challenge challenge;
  final QuizQuestion question;
  final Function(bool) onAnswered;

  const QuizOverlay({
    super.key,
    required this.challenge,
    required this.question,
    required this.onAnswered,
  });

  @override
  State<QuizOverlay> createState() => _QuizOverlayState();
}

class _QuizOverlayState extends State<QuizOverlay>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _shakeController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
                _shakeAnimation.value *
                    ((_shakeController.value * 10).toInt() % 2 == 0 ? 1 : -1),
                0),
            child: child,
          );
        },
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: FayColors.gold.withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Premium Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FayColors.gold,
                          FayColors.gold.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.menu_book_rounded,
                            color: FayColors.navy,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.challenge.topic.toUpperCase(),
                          style: const TextStyle(
                            color: FayColors.navy,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Text(
                          widget.question.questionText,
                          style: const TextStyle(
                            color: FayColors.text,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ...widget.question.options.asMap().entries.map((entry) {
                          final index = entry.key;
                          final option = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  bool correct = index ==
                                      widget.question.correctOptionIndex;
                                  if (!correct) {
                                    _shakeController.forward(from: 0);
                                  }
                                  widget.onAnswered(correct);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: FayColors.navy,
                                  foregroundColor: FayColors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  option,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
