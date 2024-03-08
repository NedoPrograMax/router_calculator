import 'package:router/core/helper/types.dart';
import 'package:router/features/router_problem/domain/entities/router_answer.dart';

class RouterAnswerModel extends RouterAnswer {
  const RouterAnswerModel({
    required super.id,
    required super.isCorrect,
  });

  RouterAnswerModel.fromJson(Json json)
      : super(
          id: json['id'],
          isCorrect: json['correct'],
        );
}
