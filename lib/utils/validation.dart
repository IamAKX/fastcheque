import 'package:fastcheque/service/snakbar_service.dart';

bool checkValidEmail(String email) {
  bool res = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (!res) SnackBarService.instance.showSnackBarError('Invalid email format');
  return res;
}

bool checkAllEmptyString(List<String> list) {
  for (String tc in list) {
    print(tc);
    if (tc.isEmpty) {
      SnackBarService.instance.showSnackBarError('All fields are mandatory');
      return false;
    }
  }
  return true;
}

bool isNumeric(String string) {
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  return numericRegex.hasMatch(string);
}
