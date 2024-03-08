import 'package:string_validator/string_validator.dart';

String? validateUrl(String? url) {
  url = url?.trim();
  if (url?.isEmpty ?? true) {
    return "Cannot be empty";
  }
  if (!isURL(url)) {
    return "Invalid URL format";
  }
  return null;
}
