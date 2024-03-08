import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:router/features/router_problem/domain/entities/router_answer.dart';
import 'package:router/features/router_problem/domain/entities/router_entity.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';
import 'package:router/features/router_problem/presentation/widgets/answer_widget.dart';

class AnswersScreen extends StatelessWidget {
  final List<RouterEntity> entities;

  const AnswersScreen({
    super.key,
    required this.entities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ListView.builder(
          itemCount: entities.length,
          itemBuilder: (context, index) => AnswerWidget(
            entity: entities[index],
            isLast: index == entities.length - 1,
          ),
        ),
      ),
    );
  }
}
