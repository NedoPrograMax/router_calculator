import 'package:router/core/helper/types.dart';

class ApiResponse {
  final bool isError;
  final String? message;
  final dynamic data;

  const ApiResponse({
    required this.isError,
    required this.message,
    required this.data,
  });

  ApiResponse.fromJson(Json json)
      : isError = json['error'],
        message = json['message'],
        data = json['data'];
}
