class NewUserController {
  NewUserController._internal();
  static final _instance = NewUserController._internal();
  factory NewUserController() => _instance;

  String? _password;
  String? _email;
  String? _username;
  String? _fullname;

  String get password {
    return _password ??= "";
  }

  String get email {
    return _email ??= "";
  }

  String get username {
    return _username ??= "";
  }

  String get fullname {
    return _fullname ??= "";
  }

  set updateEmail(String value) {
    _email = value;
  }

  set updateUsername(String value) {
    _username = value;
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
      "username": _username,
      "balance": 0.0001,
    };
  }

  void dispose() {
    _email = null;
    _fullname = null;
    _password = null;
  }
}
