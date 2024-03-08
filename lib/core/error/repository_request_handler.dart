import 'package:dartz/dartz.dart';
import 'package:router/core/error/error_handler.dart';
import 'package:router/core/error/failures.dart';
import 'package:router/core/helper/types.dart';

class RepositoryRequestHandler<T> {
  FutureFailable<T> call({
    Failure? defaultFailure,
    required Future<T> Function() request,
  }) async {
    try {
      return Right(await request());
    } catch (error) {
      final failure = await errorHandler(error, defaultFailure);

      return Left(failure);
    }
  }
}
