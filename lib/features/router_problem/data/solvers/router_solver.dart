import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:router/features/router_problem/data/models/field_cell.dart';
import 'package:router/features/router_problem/data/models/router_solution_model.dart';
import 'package:router/features/router_problem/data/solvers/graph.dart';
import 'package:router/features/router_problem/data/solvers/graph_node.dart';

import 'package:router/features/router_problem/domain/entities/router_problem.dart';
import 'package:router/features/router_problem/domain/entities/router_solution.dart';
import 'package:router/features/router_problem/domain/types/soultion_progress.dart';

abstract class RouterSolver {
  static Stream<SolutionProgress> solveProblemsAndGetProgress(
      List<RouterProblem> problems) {
    final streamController = StreamController<SolutionProgress>.broadcast();
    _calculateProblems(problems, streamController);

    return streamController.stream;
  }

  static Future<void> _calculateProblems(List<RouterProblem> problems,
      StreamController<SolutionProgress> streamController) async {
    final progressesMap = <RouterProblem, double>{};
    final calculationsFutures = problems.map((problem) {
      final graph = _createGraphFromFields(problem.field);
      return graph.calculateShortestPathUsingBfs(
        start: GraphNode(element: problem.startCell),
        end: GraphNode(element: problem.endCell),
        progressCallback: (progress) {
          progressesMap[problem] = progress;
          final averageProgress = progressesMap.length != problems.length
              ? 0.0
              : progressesMap.values.fold(0.0,
                      (previousValue, element) => previousValue + element) /
                  progressesMap.length;
          streamController.sink.add(Left(averageProgress));
        },
      );
    });

    final calculationResults = await Future.wait(calculationsFutures);
    final solutions = <RouterSolution>[];
    for (var i = 0; i < problems.length; i++) {
      final cells = calculationResults[i];
      solutions.add(
        RouterSolutionModel(
          id: problems[i].id,
          steps: cells,
          path: cells._toPath(),
        ),
      );
    }

    streamController.sink.add(Right(solutions));
    streamController.close();
  }

  static Graph<FieldCell> _createGraphFromFields(List<String> field) {
    final nodes = _nodesFromField(field);
    return Graph(graph: nodes);
  }

  static Map<GraphNode<FieldCell>, List<GraphNode<FieldCell>>> _nodesFromField(
      List<String> field) {
    final Map<GraphNode<FieldCell>, List<GraphNode<FieldCell>>> nodesMap = {};
    bool isCellValid(FieldCell cell) {
      if (cell.x < 0 || cell.x >= field.first.length) {
        return false;
      }
      if (cell.y < 0 || cell.y >= field.length) {
        return false;
      }
      if (field[cell.y][cell.x] != '.') {
        return false;
      }
      return true;
    }

    for (var line = 0; line < field.length; line++) {
      for (var column = 0; column < field[line].length; column++) {
        final cellSymbol = field[line][column];
        if (cellSymbol != '.') {
          continue;
        }
        final currentCell = FieldCell(x: column, y: line);
        final currentCellNode = GraphNode(element: currentCell);
        final topCell = FieldCell(x: column, y: line - 1);
        final topRightCell = FieldCell(x: column + 1, y: line - 1);
        final rightCell = FieldCell(x: column + 1, y: line);
        final bottomRightCell = FieldCell(x: column + 1, y: line + 1);
        final bottomCell = FieldCell(x: column, y: line + 1);
        final bottomLeftCell = FieldCell(x: column - 1, y: line + 1);
        final leftCell = FieldCell(x: column - 1, y: line);
        final topLeftCell = FieldCell(x: column - 1, y: line - 1);
        final neighbours = <FieldCell>[
          topCell,
          topRightCell,
          rightCell,
          bottomRightCell,
          bottomCell,
          bottomLeftCell,
          leftCell,
          topLeftCell,
        ];

        for (var cell in neighbours) {
          if (isCellValid(cell)) {
            if (nodesMap.containsKey(currentCellNode)) {
              nodesMap[currentCellNode]!.add(GraphNode(element: cell));
            } else {
              nodesMap[currentCellNode] = [GraphNode(element: cell)];
            }
          }
        }
      }
    }
    return nodesMap;
  }
}

extension FieldCellsExtension on List<FieldCell> {
  String _toPath() {
    var path = "";
    for (var i = 0; i < length; i++) {
      final cell = this[i];
      if (i == length - 1) {
        path += cell.toPathFragment(withArrowNext: false);
      } else {
        path += cell.toPathFragment(withArrowNext: true);
      }
    }
    return path;
  }
}
