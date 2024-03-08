part of 'url_cubit.dart';

abstract class UrlState {
  final String? url;

  UrlState({required this.url});
}

class UrlInitial extends UrlState {
  UrlInitial() : super(url: null);
}

class UrlLoading extends UrlState {
  UrlLoading({required super.url});
}

class UrlData extends UrlState {
  UrlData({required super.url});
}

class UrlSucess extends UrlState {
  UrlSucess({required super.url});
}

class UrlFailure extends UrlState {
  final Failure failure;

  UrlFailure({
    required this.failure,
  }) : super(url: null);
}
