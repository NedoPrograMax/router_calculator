import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:router/features/router_problem/domain/entities/router_answer.dart';
import 'package:router/features/router_problem/domain/entities/router_entity.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';
import 'package:router/features/router_problem/presentation/screens/solution_screen.dart';
import 'package:router/features/router_problem/presentation/widgets/correctness_displayer.dart';
import 'package:router/features/router_problem/presentation/widgets/custom_divider.dart';

class AnswerWidget extends StatelessWidget {
  final RouterEntity entity;
  final bool isLast;
  const AnswerWidget({
    super.key,
    required this.entity,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SolutionScreen(entity: entity),
            ),
          );
        },
        child: Ink(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        entity.path,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    CorrectnessDisplayer(isCorrect: entity.isCorrect)
                  ],
                ),
              ),
              if (!isLast) const CustomDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
