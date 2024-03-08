import 'package:flutter/material.dart';

class CorrectnessDisplayer extends StatelessWidget {
  final bool isCorrect;
  const CorrectnessDisplayer({
    super.key,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return isCorrect
        ? const Icon(Icons.check, color: Colors.green)
        : const Icon(Icons.cancel_outlined, color: Colors.red);
  }
}
