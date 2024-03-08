import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  final SharedPreferences sharedPreferences;

  static const _urlKey = 'URL';

  SharedPreferencesRepository({required this.sharedPreferences});

  Future<bool> saveUrl(String url) {
    return sharedPreferences.setString(_urlKey, url);
  }

  String? getUrl() {
    return sharedPreferences.getString(_urlKey);
  }

  Future<bool> deleteUrl() {
    return sharedPreferences.remove(_urlKey);
  }
}
