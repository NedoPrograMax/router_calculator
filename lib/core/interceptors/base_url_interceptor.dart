import 'package:dio/dio.dart';

import 'package:router/core/helper/shared_preferences_repository.dart';

class BaseUrlInterceptor extends Interceptor {
  BaseUrlInterceptor({
    required this.sharedPreferencesRepository,
  });

  final SharedPreferencesRepository sharedPreferencesRepository;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String? localUrl = sharedPreferencesRepository.getUrl();

    if (localUrl != null && localUrl.isNotEmpty) {
      final url = Uri.tryParse(localUrl);

      final baseUrl = (url?.origin ?? "") + (url?.path ?? "");
      options.queryParameters = url?.queryParameters ?? {};
      options.baseUrl = baseUrl;
    }

    super.onRequest(options, handler);
  }
}
