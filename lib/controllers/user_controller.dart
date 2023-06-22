import '../models/user.dart';

class UserController {
  UserController._internal();
  static final _instance = UserController._internal();
  factory UserController() => _instance;
  User? _currentUser;

  User get currentUser {
    return _currentUser!;
  }

  void initialize(User user) {
    _currentUser = user;
  }

  void dispose() {
    _currentUser = null;
  }
}
