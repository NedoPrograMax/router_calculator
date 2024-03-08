import 'package:router/core/error/repository_request_handler.dart';
import 'package:router/core/helper/types.dart';
import 'package:router/features/url_setter/data/datasources/url_setter_datasource.dart';

abstract class UrlSetterRepository {
  FutureFailable<void> setUrl(String url);

  FutureFailable<String> getUrl();

  FutureFailable<void> deleteUrl();
}
