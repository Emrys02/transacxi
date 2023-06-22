import 'package:flutter/services.dart';

class InputFormatters {
  InputFormatters._();

  static final fullname = [FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")), FilteringTextInputFormatter.deny(RegExp("[A-Z][A-Z]"))];
}
