import 'package:router/core/error/failures.dart';
import 'package:router/core/error/repository_request_handler.dart';
import 'package:router/core/helper/types.dart';
import 'package:router/features/url_setter/data/datasources/url_setter_datasource.dart';
import 'package:router/features/url_setter/domain/repositories/url_setter_repository.dart';

class UrlSetterRepositoryImpl implements UrlSetterRepository {
  final UrlSetterDatasource datasource;

  UrlSetterRepositoryImpl({required this.datasource});
  @override
  FutureFailable<String> getUrl() {
    return RepositoryRequestHandler<String>()(
      request: () => datasource.getUrl(),
      defaultFailure: CacheFailure(),
    );
  }

  @override
  FutureFailable<void> setUrl(String url) {
    return RepositoryRequestHandler<void>()(
      request: () => datasource.saveUrl(url),
      defaultFailure: CacheFailure(),
    );
  }

  @override
  FutureFailable<void> deleteUrl() {
    return RepositoryRequestHandler<void>()(
      request: () => datasource.deleteUrl(),
      defaultFailure: CacheFailure(),
    );
  }
}
