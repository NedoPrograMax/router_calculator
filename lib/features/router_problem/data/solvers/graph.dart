import 'dart:collection';

import 'package:router/features/router_problem/data/solvers/graph_node.dart';

class Graph<T> {
  final Map<GraphNode<T>, List<GraphNode<T>>> _graph;

  Graph({required Map<GraphNode<T>, List<GraphNode<T>>> graph})
      : _graph = graph;

  Future<List<T>> calculateShortestPathUsingBfs({
    required GraphNode<T> start,
    required GraphNode<T> end,
    required void Function(double progress) progressCallback,
  }) async {
    final visited = <GraphNode<T>>{};

    final queue = Queue<GraphNode<T>>();

    visited.add(start);
    queue.add(start);

    final Map<GraphNode<T>, GraphNode<T>?> paths = {
      for (var vertex in _graph.keys) vertex: null
    };

    while (queue.isNotEmpty) {
      final currentNode = queue.removeFirst();

      var progress = visited.length / _graph.length;
      progressCallback(progress);
      await Future.delayed(const Duration(milliseconds: 200));

      if (currentNode == end) {
        progressCallback(1.0);
        break;
      }

      for (var neighbor in _graph[currentNode]!) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add(neighbor);
          paths[neighbor] = currentNode;
        }
      }
    }

    var path = <T>[];
    var current = end;
    while (current != start) {
      path.insert(0, current.element);
      current = paths[current]!;
    }
    path.insert(0, start.element);

    return path;
  }
}
