import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object> get props => [];

  final String errorMessage;

  final int? errorCode;

  const Failure({
    this.errorCode,
    String? errorMessage,
  }) : errorMessage = errorMessage ?? "Some error occured";

  @override
  String toString() {
    return "Failure(errorMessage: $errorMessage, errorCode: $errorCode)";
  }
}

// General failures
class InternetConnectionFailure extends Failure {
  const InternetConnectionFailure()
      : super(errorMessage: "Internet connection error");
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
