import '../../controllers/new_user_controller.dart';

class InputValidators {
  InputValidators._();
  static final _newUserController = NewUserController();

  static String? email(String? value) {
    if (value == null || value.isEmpty) return "required";
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$').hasMatch(value)) return "Invalid email address";
    return null;
  }

  static String? fullname(String? value) {
    if (value == null || value.isEmpty) return "required";
    if (value.split(" ").length < 2) return "Firstname Lastname";
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return "required";
    if (value.length < 8) return "too short";
    if (!value.contains(RegExp("[0-9A-Za-z]"))) return "Must contain numbers, upper and lower case characters";
    return null;
  }

  static String? confirmPassword(String? value) {
    if (value != _newUserController.password) return "Passwords do not matc7";
    return null;
  }
}
