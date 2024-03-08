import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:router/core/error/failures.dart';
import 'package:router/core/models/api_response.dart';

Future<Failure> errorHandler(Object error, Failure? defaultFailure) async {
  try {
    if (error is DioException) {
      print(error.response);

      if (error.type == DioExceptionType.connectionError) {
        if (error.error is SocketException) {
          return Failure(
            errorMessage:
                "Connection error. Please check entered url availability or your Internet status",
            errorCode: error.response?.statusCode,
          );
        }
      }

      if (error.response?.data != null) {
        final response = ApiResponse.fromJson(error.response?.data);
        return Failure(
          errorMessage: response.message,
          errorCode: error.response?.statusCode,
        );
      }
    }

    return defaultFailure!;
  } catch (err) {
    return const Failure();
  }
}

class MessageException extends Equatable implements Exception {
  final String? message;
  const MessageException({this.message});

  @override
  List<Object?> get props => [message];
  @override
  bool? get stringify => true;
}

class NetworkException extends MessageException {
  const NetworkException({super.message});
}

class CacheException extends MessageException {
  const CacheException({super.message});
}
