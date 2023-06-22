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

  void dispose() {
    _email = null;
    _fullname = null;
    _password = null;
  }
}
