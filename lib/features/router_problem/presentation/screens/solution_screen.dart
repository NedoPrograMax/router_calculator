import 'package:flutter/material.dart';
import 'package:router/features/router_problem/data/models/field_cell.dart';
import 'package:router/features/router_problem/domain/entities/router_entity.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';
import 'package:router/features/router_problem/presentation/widgets/cell_widget.dart';

class SolutionScreen extends StatelessWidget {
  final RouterEntity entity;
  const SolutionScreen({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solution"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: entity.field.first.length,
                ),
                itemCount: entity.field.length * entity.field.first.length,
                itemBuilder: (context, index) {
                  final cell = getCellByIndex(index);
                  return CellWidget(
                    cell: cell,
                    color: getColorByFieldCell(cell),
                  );
                }),
            const SizedBox(height: 16),
            Text(
              entity.path,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FieldCell getCellByIndex(int index) {
    final line = index ~/ entity.field.first.length;
    final column = index % entity.field.first.length;
    return FieldCell(x: column, y: line);
  }

  Color getColorByFieldCell(FieldCell cell) {
    final symbol = entity.field[cell.y][cell.x];
    if (symbol == '.') {
      if (cell == entity.steps.first) {
        return const Color.fromARGB(255, 100, 255, 219);
      }
      if (cell == entity.steps.last) {
        return const Color.fromARGB(255, 0, 150, 135);
      }
      if (entity.steps.contains(cell)) {
        return const Color.fromARGB(255, 76, 175, 79);
      }
      return Colors.white;
    }
    return Colors.black;
  }
}
