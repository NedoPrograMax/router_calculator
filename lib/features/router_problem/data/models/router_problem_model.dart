import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/data/models/field_cell.dart';
import 'package:router/features/router_problem/domain/entities/router_problem.dart';

class RouterProblemModel extends RouterProblem {
  const RouterProblemModel({
    required super.id,
    required super.field,
    required super.startCell,
    required super.endCell,
  });

  RouterProblemModel.fromJson(Json json)
      : super(
          id: json['id'],
          field: List.from(json['field']),
          startCell: FieldCell.fromJson(json['start']),
          endCell: FieldCell.fromJson(json['end']),
        );
}
