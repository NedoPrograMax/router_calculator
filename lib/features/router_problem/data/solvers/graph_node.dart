import 'package:equatable/equatable.dart';

class GraphNode<T> extends Equatable {
  final T element;

  const GraphNode({required this.element});

  @override
  List<Object?> get props => [element];
}
