import 'dart:math';

class NewUserController {
  NewUserController._internal();
  static final _instance = NewUserController._internal();
  factory NewUserController() => _instance;

  String? _password;
  String? _email;
  String? _fullname;

  String get password {
    return _password ??= "";
  }

  String get email {
    return _email ??= "";
  }

  String get fullname {
    return _fullname ??= "";
  }

  set updateEmail(String value) {
    _email = value;
  }

  set updatePassword(String value) {
    _password = value;
  }

  set updateFullname(String value) {
    _fullname = value;
  }

  Map<String, dynamic> toMap() {
    return {
      "firstname": _fullname!.split(" ").first,
      "lastname": _fullname!.split(" ").last,
      "fullname": _fullname,
      "email": _email,
      "accountNumber": List.generate(10, (index) => Random().nextInt(9)).toString().replaceAll(",", "").replaceAll("[", "").replaceAll("]", ""),
      "balance": 0.0,
    };
  }

  void dispose() {
    _email = null;
    _fullname = null;
    _password = null;
  }
}
