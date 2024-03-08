import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:router/core/error/failures.dart';
import 'package:router/features/url_setter/domain/repositories/url_setter_repository.dart';

part 'url_state.dart';

class UrlCubit extends Cubit<UrlState> {
  final UrlSetterRepository repository;
  UrlCubit({
    required this.repository,
  }) : super(UrlInitial());

  void getUrl() async {
    emit(UrlLoading(url: state.url));
    final result = await repository.getUrl();
    result.fold(
      (failure) => emit(UrlFailure(failure: failure)),
      (url) => emit(UrlData(url: url)),
    );
  }

  void setUrl(String url) async {
    final result = await repository.setUrl(url);
    result.fold(
      (failure) => emit(UrlFailure(failure: failure)),
      (_) => emit(UrlSucess(url: url)),
    );
  }

  void deleteUrl() async {
    final result = await repository.deleteUrl();
    result.fold(
      (failure) => emit(UrlFailure(failure: failure)),
      (url) => emit(UrlInitial()),
    );
  }
}
