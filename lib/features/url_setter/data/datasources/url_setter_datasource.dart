import 'package:router/core/error/error_handler.dart';
import 'package:router/core/helper/shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UrlSetterDatasource {
  Future<void> saveUrl(String url);

  Future<String> getUrl();

  Future<void> deleteUrl();
}

class UrlSetterDatasourceImpl implements UrlSetterDatasource {
  final SharedPreferencesRepository sharedPreferencesRepository;

  UrlSetterDatasourceImpl({required this.sharedPreferencesRepository});

  @override
  Future<void> saveUrl(String url) {
    return sharedPreferencesRepository.saveUrl(url);
  }

  @override
  Future<String> getUrl() async {
    final result = sharedPreferencesRepository.getUrl();
    if (result != null && result.isNotEmpty) {
      return result;
    }
    throw const CacheException(
      message:
          "Couldn't find the URL. Probably it wasn't saved before or local cache was cleared",
    );
  }

  @override
  Future<void> deleteUrl() {
    return sharedPreferencesRepository.deleteUrl();
  }
}
