import 'package:equatable/equatable.dart';
import 'package:router/core/helper/types.dart';

class FieldCell extends Equatable {
  const FieldCell({
    required this.x,
    required this.y,
  });

  final int x;
  final int y;

  FieldCell.fromJson(Json json)
      : x = json['x'],
        y = json['y'];

  Json toJson() => {
        'x': x,
        'y': y,
      };

  @override
  List<Object?> get props => [x, y];

  String toPathFragment({required bool withArrowNext}) =>
      "($x,$y)${withArrowNext ? '->' : ''}";
}
